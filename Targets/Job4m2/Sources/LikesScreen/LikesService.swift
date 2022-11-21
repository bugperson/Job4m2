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
            route: Route.User.likes.asPath,
            method: .get
        )
        let cardsDTO: [LikeDTO]? = await apiService.perform(route: route)

        return (cardsDTO ?? []).map { like in
            let tags = like.tags.map { tag in
                TagModel(
                    id: tag.id,
                    text: tag.text,
                    color: TagColor.randomColor
                )
            }

            return CardModel(
                id: like.id,
                imagePath: like.pictureUrl,
                title: like.title,
                subtitile: like.subtitle,
                description: like.description,
                tags: tags,
                tgLink: like.tgLink
            )
        }
    }
}
