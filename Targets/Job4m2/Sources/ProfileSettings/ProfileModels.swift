//
//  ProfileModels.swift
//  Job4m2
//
//  Created by Danil Dubov on 20.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

struct ProfileModel {
    let name: String
    let age: Int
    let education: String
    let company: String
    let description: String
    let tg_link: String
    let image: String
    let type: String
    let tags: [ProfileTag]
    let attachments: [Attachments]
}

struct ProfileTag: Identifiable, Codable {

    let id: Int
    let text: String
    let isSelected: Bool
}

