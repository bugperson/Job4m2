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

    @State private var alertOpacity = 0.0
    @State private var alertType: AlertType = .none

    @State var isAlertOnCardEnabled = false

    var body: some View {
        ZStack (alignment: .topLeading) {
            Rectangle()
                .foregroundColor(CardColors.cardBackGround)

            VStack {
                if isAlertOnCardEnabled {
                    ZStack(alignment: .center) {
                        image
                            .opacity(backgroundOpacity)
                        AlertView(alertType: $alertType)
                            .opacity(alertOpacity)
                    }
                } else {
                    image
                        .opacity(backgroundOpacity)
                }

                textContent
                    .padding()
            }
        }
        .frame(width: 361, height: 662, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .shadow(radius: 10)
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            dragCardGesture
        )
    }

    var image: some View {
        CachedAsyncImage(url: URL(string: model.imagePath)) { image in
            image
                .resizable()
                .aspectRatio(CGSize(width: 361, height: 467), contentMode: .fit)
                .frame(alignment: .top)
                .cornerRadius(40)
        } placeholder: {
            ZStack {
                Job4m2Asset.dog.image.asImage()
                    .resizable()
                    .aspectRatio(CGSize(width: 361, height: 467), contentMode: .fit)
                    .frame(alignment: .top)
                    .cornerRadius(40)
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

    var dragCardGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                withAnimation {
                    let value = UIScreen.main.bounds.width
                    if gesture.translation.width > 0 {
                        backgroundOpacity = 1 - gesture.translation.width / value
                        alertOpacity = gesture.translation.width / value * 4
                        alertType = .like
                    } else {
                        backgroundOpacity = 1 + gesture.translation.width / value
                        alertOpacity = gesture.translation.width / value * -4
                        alertType = .dislike
                    }
                }
            }
            .onEnded { _ in
                withAnimation {
                    swipeCard(width: offset.width)
                }
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
                alertOpacity = 0
                alertType = .none
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
