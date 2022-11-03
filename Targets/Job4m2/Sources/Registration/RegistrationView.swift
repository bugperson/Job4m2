import Foundation
import SwiftUI

struct RegistrationView: View {

    @ObservedObject var controller: RegistrationController
    typealias LocalStrings = Strings.Registration

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Picker(
                        "Вы: ",
                        selection: $controller.segmentSelected
                    ) {
                        Text("При бабках").tag(0)
                        Text("Без бабок").tag(1)
                    }
                    .pickerStyle(.segmented)
                    TextField(LocalStrings.username, text: $controller.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField(LocalStrings.password, text: $controller.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField(
                        controller.userType == .workFinder ? LocalStrings.name : "Название компании",
                        text: $controller.name
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], spacing: 5) {
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
                    .scrollIndicators(.hidden)
                    .frame(height: 75)

                    if controller.userType == .workFinder {
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
                        
                        TextField(
                            LocalStrings.company,
                            text: $controller.company
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .transition(.slide)
                        .animation(.easeInOut(duration: Constants.animationDuration))
                    }
                    
                    TextField(LocalStrings.telegramName, text: $controller.telegrammName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .transition(.move(edge: .top))
                        .animation(.easeInOut(duration: Constants.animationDuration))
                    TextField(controller.userType == .workFinder ? LocalStrings.description : "О компании", text: $controller.description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .transition(.move(edge: .top))
                        .animation(.easeInOut(duration: Constants.animationDuration))
                    
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                controller.registrate()
                            },
                            label: {
                                Label {
                                    Text("Зарегестрироваться")
                                } icon: {
                                    Image(systemName: "brain")
                                }
                            }
                        )
                        .disabled(!controller.isAllFiled)
                        Spacer()
                    }
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: Constants.animationDuration))
                    
                    
                }
                .onAppear {
                    controller.onApear()
                }
                .padding()
            }
        }.blendMode(.exclusion)
    }
}

private enum Constants {

    static let animationDuration = 0.3
}
