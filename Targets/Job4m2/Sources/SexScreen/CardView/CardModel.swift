//
//  CardController.swift
//  Job4m2
//
//  Created by Danil Dubov on 01.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import SwiftUI

struct CardModel: Identifiable {
    var id: Int
    var imagePath: String = ""
    var title: String = ""
    var description: String = ""
    var tags: [TagModel] = []
    var swipeLikeAction: Action?
    var swipeDislikeAction: Action?
}

extension CardModel {
    static let stub = CardModel(
        id: 1,
        imagePath: "",
        title: "Sex 1",
        description: "Какое-то описание - ваще похуйю",
        tags: [
            TagModel(id: 1, text: "Jopa", color: .blue),
            TagModel(id: 2, text: "Jopa2", color: .lightGreen),
            TagModel(id: 3, text: "Jopa3", color: .deepBlue),
            TagModel(id: 4, text: "Jopa4", color: .deepPurple),
            TagModel(id: 5, text: "Jopa5", color: .purple),
            TagModel(id: 6, text: "Jopa6", color: .deepGreen)
        ]
    )

    static let stub2 = CardModel(
        id: 2,
        imagePath: "",
        title: "Sex 2",
        description: "Какое-то описание - ваще похуйю",
        tags: [
            TagModel(id: 1, text: "Jopa", color: .blue),
            TagModel(id: 2, text: "Jopa2", color: .lightGreen),
            TagModel(id: 3, text: "Jopa3", color: .deepBlue),
            TagModel(id: 4, text: "Jopa4", color: .deepPurple),
            TagModel(id: 5, text: "Jopa5", color: .purple),
            TagModel(id: 6, text: "Jopa6", color: .deepGreen)
        ]
    )

    static let stub3 = CardModel(
        id: 3,
        imagePath: "",
        title: "Sex 3",
        description: "Какое-то описание - ваще похуйю",
        tags: [
            TagModel(id: 1, text: "Jopa", color: .blue),
            TagModel(id: 2, text: "Jopa2", color: .lightGreen),
            TagModel(id: 3, text: "Jopa3", color: .deepBlue),
            TagModel(id: 4, text: "Jopa4", color: .deepPurple),
            TagModel(id: 5, text: "Jopa5", color: .purple),
            TagModel(id: 6, text: "Jopa6", color: .deepGreen)
        ]
    )

    static let stub4 = CardModel(
        id: 4,
        imagePath: "",
        title: "Sex 4",
        description: "Какое-то описание - ваще похуйю",
        tags: [
            TagModel(id: 1, text: "Jopa", color: .blue),
            TagModel(id: 2, text: "Jopa2", color: .lightGreen),
            TagModel(id: 3, text: "Jopa3", color: .deepBlue),
            TagModel(id: 4, text: "Jopa4", color: .deepPurple),
            TagModel(id: 5, text: "Jopa5", color: .purple),
            TagModel(id: 6, text: "Jopa6", color: .deepGreen)
        ]
    )
}
