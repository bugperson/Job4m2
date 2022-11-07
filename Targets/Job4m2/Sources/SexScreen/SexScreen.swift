//
//  SexScreen.swift
//  Job4m2
//
//  Created by Danil Dubov on 03.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI
import Foundation

struct SexScreen: View {
    @ObservedObject var controller: SexController

    var body: some View {
        VStack {
            if controller.cards.count > 0 {
                HStack() {
                    Button {
                        controller.exit?()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .font(.system(size: 32))
                            .foregroundColor(.red)
                    }

                    Spacer()

                    Button {
                        controller.openProfileSettings?()
                    } label: {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Button {
                        controller.openLikes?()
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 32))
                    }
                }
                .padding()
            }
            ZStack {
                makeCard(with: controller.index + 1)
                makeCard(with: controller.index)
            }
            .padding()
        }
        .onAppear {
            controller.onAppear()
        }
        .alert(alertType: $controller.alertType, isPresented: $controller.isAlertPresented)
    }

    @ViewBuilder
    func makeCard(with index: Int) -> some View {
        if controller.cards.count > 0 {
            CardView(model: controller.cards[index % controller.cards.count])
                .id(controller.cards[index % controller.cards.count].id)
        } else {
            TimerView {
                controller.onAppear()
            }
        }
    }
}

struct TimerView: View {

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let comletion: Action
    @State var timeRemaining = 5
    @State var reloadRequestEnabled = true

    var body: some View {
        VStack {
          Text(String(timeRemaining))
            .font(.title)
            .bold()
            .font(.system(size: 30))
            .onReceive(timer) { time in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timeRemaining = 0
                    reloadRequestEnabled = false
                }
            }
            Button {
                comletion()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 200, height: 30)
                    .foregroundColor(.black)
                    .overlay {
                        Text("Попробовать еще раз?")
                            .foregroundColor(.white)
                    }
            }
            .disabled(reloadRequestEnabled)
        }
    }
}

struct SexScreen_Previews: PreviewProvider {
    static var previews: some View {
        SexScreen(controller: SexController())
    }
}
