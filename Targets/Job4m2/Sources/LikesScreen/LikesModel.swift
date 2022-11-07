//
//  LikesModel.swift
//  Job4m2
//
//  Created by Danil Dubov on 07.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

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
