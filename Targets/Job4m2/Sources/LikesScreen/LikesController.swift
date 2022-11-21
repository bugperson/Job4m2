//
//  LikesController.swift
//  Job4m2
//
//  Created by Danil Dubov on 07.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import SwiftUI

final class LikesController: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var isFetchSuccess = false

    private var likesService = LikesService()

    var startWithCardId: Int = 0

    func onAppear() {
        Task {
            let fetchedCardsResult = await likesService.fetchCards()

            switch fetchedCardsResult {
            case .success(let success):
                await MainActor.run { [success] in
                    cards = success
                    isFetchSuccess = true
                    print(cards)
                }
            case .failure(_):
                isFetchSuccess = false
            }

        }
    }
}
