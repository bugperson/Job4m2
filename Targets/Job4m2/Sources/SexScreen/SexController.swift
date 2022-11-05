//
//  SexController.swift
//  Job4m2
//
//  Created by Danil Dubov on 03.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import Combine

final class SexController: ObservableObject {
    @Published var index: Int = 0
    @Published var isAlertPresented = false
    @Published var alertType: AlertType = .like

    @MainActor @Published var cards: [CardModel] = []

    private let sexService = SexService()

    func onAppear() {
        let action: CardModel.SwipeAction = { [weak self] id, actionType in
            guard let self else { return }
            Task {
                let _ = await self.sexService.sendCardAcion(with: id, actionType: actionType)

                await MainActor.run {
                    self.index += 1
                    self.alertType = actionType.toAlertType()
                    self.isAlertPresented = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isAlertPresented = false
                    }
                }
            }
        }

        Task {
            let fetchedCards = await sexService.fetchCards(with: action)

            await MainActor.run { [fetchedCards] in
                cards = fetchedCards
                print(cards)
            }
        }
    }
}

