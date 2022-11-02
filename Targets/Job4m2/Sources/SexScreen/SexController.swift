//
//  SexController.swift
//  Job4m2
//
//  Created by Danil Dubov on 03.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation

final class SexController: ObservableObject {
    @Published var index: Int = 0
    @Published var cards: [CardModel] = []

    func onAppear() {
        cards = [
            .stub,
            .stub2,
            .stub3,
            .stub4
        ]
        cards = cards.map { card in
            CardModel(
                id: card.id,
                imagePath: card.imagePath,
                title: card.title,
                description: card.description,
                tags: card.tags
            ) { [weak self] in
                    self?.index += 1
                    print(self?.index)
                    print(card.id)
                }
        }
    }
}
