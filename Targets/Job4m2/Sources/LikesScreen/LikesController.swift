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
    @Published var cards: [LikesModel] = []

    private var likesService = LikesService()

    func onAppear() {
        Task {
            let fetchedCards = await likesService.fetchCards()

            await MainActor.run { [fetchedCards] in
                cards = fetchedCards
                print(cards)
            }
        }
    }
}
