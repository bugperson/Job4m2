//
//  LikesView.swift
//  Job4m2
//
//  Created by Danil Dubov on 07.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct LikesView: View {
    @ObservedObject var controller: LikesController

    @State var isTGLinkVisible = false
    @State var tgLinkText = "Upss"

    var body: some View {
        ScrollView {
            if !controller.cards.isEmpty {
                VStack {
                    ForEach(controller.cards) { cardModel in
                        CardView(model: cardModel)
                            .padding()
                            .onTapGesture {
                                tgLinkText = cardModel.tgLink
                                isTGLinkVisible = true
                                UIApplication.shared.open(URL(string: cardModel.tgLink)!)
                            }
                    }
                }
            } else {
                Text("Упс тебя никто не возьмет на работу :(")
            }
        }
//        .tgAlert(tgLink: $tgLinkText, isPresented: $isTGLinkVisible)
        .onTapGesture {
            isTGLinkVisible = false
        }
        .onAppear {
            controller.onAppear()
        }
    }

    @ViewBuilder
    func makeCard(with model: LikesModel) -> some View {
        CachedAsyncImage(url: model.pictureUrl!) { image in
            ZStack (alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(CardColors.cardBackGround)

                VStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                        .cornerRadius(12)

                    Text(model.title)
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .padding()
                }
            }
            .frame(width: 100, height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 10)
            .padding()
        } placeholder: {
            Job4m2Asset.defaultphoto.image.asImage()
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 150)
                .padding()
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView(controller: LikesController())
    }
}
