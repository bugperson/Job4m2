//
//  CardView.swift
//  Job4m2
//
//  Created by Danil Dubov on 01.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var model: CardModel

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
    }

    var textContent: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .foregroundColor(.white)
                .font(.title)

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
                .font(.body)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: CardModel.stub)
    }
}
