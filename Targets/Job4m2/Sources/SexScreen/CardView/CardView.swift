//
//  CardView.swift
//  Job4m2
//
//  Created by Danil Dubov on 01.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var controller: CardController

    var body: some View {
        AsyncImage(url: URL(string: controller.imagePath)) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .overlay(alignment: .bottomLeading) {
                    textContent
                        .padding()
                }
        } placeholder: {
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(20)
                .overlay() {
                    VStack {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundColor(.black)
                        textContent
                            .frame(alignment: .bottomLeading)
                            .padding()
                    }
                }
        }
        .onAppear {
            controller.onAppear()
        }
    }

    var textContent: some View {
        VStack(alignment: .leading) {
            Text(controller.title)
                .foregroundColor(.white)
                .font(.title)

            

            Text(controller.description)
                .foregroundColor(.white)
                .font(.body)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(controller: CardController())
    }
}
