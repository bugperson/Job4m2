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
    @MainActor @Published var cards: [CardModel] = []

    private let sexService = SexService()

    func onAppear() {
        let likeAction = { [weak self] in
            self?.index += 1
            print(self?.index)
        }

        let dislikeAction = { [weak self] in
            self?.index += 1
            print(self?.index)
        }

        Task {
            let fetchedCards = await sexService.fetchCards(with: (likeAction, dislikeAction))

            await MainActor.run { [fetchedCards] in
                cards = fetchedCards
                print(cards)
            }
        }
    }
}
