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
}

extension CardModel {
    static let stub = CardModel(
        id: 1,
        imagePath: "",
        title: "Jopa, 23",
        description: "asdfjasj;dlfasl;dkfja;sldkfja;lsdf",
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
