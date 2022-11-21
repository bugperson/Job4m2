//
//  LikesDTO.swift
//  Job4m2
//
//  Created by Danil Dubov on 21.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

struct LikesDTO: Codable {
    let card: LikeDTO
}

struct LikeDTO: Codable {
    private enum CodingKeys: String, CodingKey {

        case id = "cid"
        case title
        case subtitle
        case description
        case pictureUrl = "picture_url"
        case tags
        case attachments
        case tgLink = "tg_link"
    }

    let id: Int
    let title: String
    let subtitle: String
    let description: String
    let pictureUrl: String
    let tags: [TagDTO]
    let attachments: [Attachments]
    let tgLink: String
}
