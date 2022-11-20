//
//  ProfileDTOs.swift
//  Job4m2
//
//  Created by Danil Dubov on 20.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

struct ProfileDTO: Codable {
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

struct ProfileUpdateDTO: Codable {
    let name: String
    let age: String
    let education: String
    let company: String
    let description: String
    let tg_link: String
    let type: String
    let tags: [Int]
    let attachments: [Attachments]
}
