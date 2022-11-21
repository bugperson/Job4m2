//
//  ProfileView.swift
//  Job4m2
//
//  Created by Danil Dubov on 20.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject var controller: ProfileController
    typealias LocalStrings = Strings.Registration

    var body: some View {
        VStack {
            ScrollView {
                photoPicker

                TextField(
                    controller.userType == .workFinder ? LocalStrings.name : "Название компании",
                    text:  controller.userType == .workFinder ? $controller.name : $controller.company
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())

                tags
                    .scrollIndicators(.hidden)
                    .frame(height: 75)

                if controller.userType == .workFinder {
                    workFinderFields
                }

                TextField(LocalStrings.telegramName, text: $controller.telegrammName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: Constants.animationDuration))
                TextField(controller.userType == .workFinder ? LocalStrings.description : "О компании", text: $controller.description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: Constants.animationDuration))

                Button {
                    controller.saveData()
                } label: {
                    Text("Сохранить")
                }
            }
        }.onAppear {
            controller.onAppear()
        }
        .padding()
    }

    var photoPicker: some View {
        PhotosPicker(
            selection: $controller.photos,
            maxSelectionCount: 1
        ) {
            if let photoData = controller.photoData,
               let image = UIImage(data: photoData) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
            } else {
                CachedAsyncImage(url: URL(string: controller.imagePath)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                } placeholder: {
                    ZStack {
                        Job4m2Asset.defaultphoto.image.asImage()
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .onChange(of: controller.photos) { newValue in
            controller.updatePhoto()
        }
    }

    var tags: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(controller.tags) { tag in
                    Text(tag.text)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .animation(nil, value: tag.id)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                                .background(tag.isSelected ? Color.brown : Color.clear)
                                .animation(nil, value: tag.id)
                        )
                        .cornerRadius(8)
                        .onTapGesture {
                            controller.onTagSelected(tagID: tag.id)
                        }
                        .animation(nil, value: tag.id)
                }
            }
        }
    }

    var workFinderFields: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Ваш возраст: \(Int(controller.slider))")
                    .frame(alignment: .leading)

                Slider(
                    value: $controller.slider,
                    in: 18...100,
                    step: 1.0,
                    onEditingChanged: { editing in
                        print(editing)
                    }
                )
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 1)
            )
            .transition(.slide)
            .animation(.easeInOut(duration: Constants.animationDuration))

            TextField(LocalStrings.education, text: $controller.education)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .transition(.slide)
                .animation(.easeInOut(duration: Constants.animationDuration))
        }
        .animation(.easeInOut(duration: Constants.animationDuration))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(controller: ProfileController())
    }
}

private enum Constants {

    static let animationDuration = 0.3
}
