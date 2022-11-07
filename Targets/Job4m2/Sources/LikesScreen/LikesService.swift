//
//  LikesService.swift
//  Job4m2
//
//  Created by Danil Dubov on 07.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

final class LikesService {
    private let apiService = APIService.shared

    func fetchCards() async -> [LikesModel] {
        let route = APIRoute(
            route: Route.User.likes.asPath,
            method: .get
        )
        let cardsDTO: [CardDTO]? = await apiService.perform(route: route)

        return (cardsDTO ?? []).map { card in
            let pictureUrl = URL(string: card.pictureUrl)
            return LikesModel(
                id: card.id,
                title: card.title,
                pictureUrl: pictureUrl
            )
        }
    }
}
