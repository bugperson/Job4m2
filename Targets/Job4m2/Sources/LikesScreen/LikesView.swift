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

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
            ) {
                ForEach(controller.cards) { cardModel in
                    makeCard(with: cardModel)
                }
            }
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
