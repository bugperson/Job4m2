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

    func fetchCards() async -> [CardModel] {
        let route = APIRoute(
            route: Route.User.match.asPath,
            method: .get
        )
        let cardsDTO: [LikesDTO]? = await apiService.perform(route: route)

        let cards: [LikesDTO] = cardsDTO ?? []

        return cards.map { like in
            let tags = like.card.tags.map { tag in
                TagModel(
                    id: tag.id,
                    text: tag.text,
                    color: TagColor.randomColor
                )
            }

            return CardModel(
                id: like.card.id,
                imagePath: like.card.pictureUrl,
                title: like.card.title,
                subtitile: like.card.subtitle,
                description: like.card.description,
                tags: tags,
                tgLink: like.tg_link
            )
        }
    }
}
