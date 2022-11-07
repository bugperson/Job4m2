//
//  LikesView.swift
//  Job4m2
//
//  Created by Danil Dubov on 07.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct LikesModel: Identifiable {
    var id: Int
    var title: String
    var pictureUrl: URL?
    var action: Action?
}

extension LikesModel {
    static let stub = LikesModel(id: 1, title: "Stub1", pictureUrl: URL(string: ""))
    static let stub2 = LikesModel(id: 2, title: "Stub2", pictureUrl: URL(string: ""))
    static let stub3 = LikesModel(id: 3, title: "Stub3", pictureUrl: URL(string: ""))
    static let stub4 = LikesModel(id: 4, title: "Stub4", pictureUrl: URL(string: ""))
    static let stub5 = LikesModel(id: 5, title: "Stub5", pictureUrl: URL(string: ""))
    static let stub6 = LikesModel(id: 6, title: "Stub6", pictureUrl: URL(string: ""))
    static let stub7 = LikesModel(id: 7, title: "Stub7", pictureUrl: URL(string: ""))
}

final class LikesService {
    private let apiService = APIService.shared

    func fetchCards() async -> [LikesModel] {
        let route = APIRoute(
            route: Route.User.likes.asPath,
            method: .get
        )
        let cardsDTO: CardsDTO? = await apiService.perform(route: route)

        return (cardsDTO?.cards ?? []).map { card in
            let pictureUrl = URL(string: card.pictureUrl)
            return LikesModel(
                id: card.id,
                title: card.title,
                pictureUrl: pictureUrl
            )
        }
    }
}

final class LikesControlelr: ObservableObject {
    @Published var cards: [LikesModel] = []

    private var likesService = LikesService()

    func onAppear() {
        cards = [
            .stub, .stub2, .stub3, .stub4, .stub5, .stub6, .stub7
        ]
//        Task {
//            let fetchedCards = await likesService.fetchCards()
//
//            await MainActor.run { [fetchedCards] in
//                cards = fetchedCards
//                print(cards)
//            }
//        }
    }
}

struct LikesView: View {
    @ObservedObject var controller: LikesControlelr

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(controller.cards) { card in
                CachedAsyncImage(url: URL(string: "https://storage.yandexcloud.net/tinderimages-test/default.jpg")!) { image in
                    ZStack (alignment: .topLeading) {
                        Rectangle()
                            .foregroundColor(CardColors.cardBackGround)
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 120)
                            .cornerRadius(12)
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
        .onAppear {
            controller.onAppear()
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView(controller: LikesControlelr())
    }
}
