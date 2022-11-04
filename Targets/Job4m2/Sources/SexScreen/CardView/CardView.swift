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
    @State private var backgroundOpacity = 1.0

    var body: some View {
        ZStack (alignment: .topLeading) {
            Rectangle()
                .foregroundColor(CardColors.cardBackGround)

            VStack {
                image
                    .opacity(backgroundOpacity)

                textContent
                    .padding()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .frame(width: 361, height: 662, alignment: .center)
        .shadow(radius: 10)
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        let value = UIScreen.main.bounds.width
                        if gesture.translation.width > 0 {
                            backgroundOpacity = 1 - gesture.translation.width / value
                        } else {
                            backgroundOpacity = 1 + gesture.translation.width / value
                        }
                    }
                    print(gesture.translation.width)
                    print(backgroundOpacity)
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                    }
                }
        )
    }

    var image: some View {
        AsyncImage(url: URL(string: model.imagePath)) { image in
            image
                .resizable()
                .frame(width: 361, height: 467, alignment: .top)
                .scaledToFill()
                .cornerRadius(40)
        } placeholder: {
            ZStack {
                Job4m2Asset.dog.image.asImage()
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(40)
                    .frame(width: 361, height: 467, alignment: .top)
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
                .font(.system(size: 32))
                .fontWeight(.medium)

            Text(model.subtitile)
                .foregroundColor(.white)
                .font(.system(size: 24))
                .fontWeight(.regular)

            Text(model.description)
                .foregroundColor(.white)
                .font(.system(size: 15))
                .fontWeight(.regular)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(model.tags, id: \.id) { tag in
                        TagView(model: tag)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
        }
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            withAnimation {
                offset = CGSize(width: -500, height: 0)
            }
            model.swipeAction?(model.id, .dislike)
        case 150...500:
            withAnimation {
                offset = CGSize(width: 500, height: 0)
            }
            model.swipeAction?(model.id, .like)
        default:
            withAnimation {
                offset = .zero
                backgroundOpacity = 1
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: CardModel.stub)
    }
}

struct CardColors {
    static let cardBackGround = UIColor(rgb: 0x292935).asColor()
}

