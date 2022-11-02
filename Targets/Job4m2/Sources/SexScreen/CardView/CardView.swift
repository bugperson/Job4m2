//
//  CardView.swift
//  Job4m2
//
//  Created by Danil Dubov on 01.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @State var model: CardModel

    @State private var offset = CGSize.zero
    @State private var color: Color = .black

    var body: some View {
        AsyncImage(url: URL(string: model.imagePath)) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .overlay(alignment: .bottomLeading) {
                    textContent
                        .padding()
                }
        } placeholder: {
            ZStack {
                Job4m2Asset.dog.image.asImage()
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .overlay(alignment: .bottomLeading) {
                        textContent
                            .padding()
                    }
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(alignment: .center)
            }
        }
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        model.swipeAction?()
                    }
                }
        )
    }

    var textContent: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(model.tags, id: \.id) { tag in
                        TagView(model: tag)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))

            Text(model.description)
                .foregroundColor(.white)
                .font(.title)
        }
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: CardModel.stub)
    }
}
