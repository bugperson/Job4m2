//
//  SexService.swift
//  Job4m2
//
//  Created by Danil Dubov on 03.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

final class SexService {
    private let apiService = APIService.shared

    func fetchCards(
        with actions: (like: Action?, dislike: Action?)
    ) async -> [CardModel] {
        let route = APIRoute(
            route: Route.User.feed.asPath,
            method: .get
        )
        let cardsDTO: CardsDTO? = await apiService.perform(route: route)

        return (cardsDTO?.cards ?? []).map { card in
            let tags = card.tags.map { tag in
                TagModel(
                    id: tag.id,
                    text: tag.text,
                    color: TagColor.randomColor
                )
            }

            return CardModel(
                id: card.id,
                imagePath: card.pictureUrl,
                title: card.title,
                subtitile: card.subtitle,
                description: card.description,
                tags: tags,
                swipeLikeAction: actions.like,
                swipeDislikeAction: actions.dislike
            )
        }
    }

    func setLike() {
        
    }
}

struct CardsDTO: Codable {
    let cards: [CardDTO]
}

struct CardDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "cid"
        case title
        case subtitle
        case description
        case pictureUrl = "picture_url"
        case tags
        case attachments
    }

    let id: Int
    let title: String
    let subtitle: String
    let description: String
    let pictureUrl: String
    let tags: [TagDTO]
    let attachments: [Attachments]
}

struct Attachments: Codable {
    let url: String
    let name: String
}
