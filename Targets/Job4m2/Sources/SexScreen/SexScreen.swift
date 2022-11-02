//
//  SexScreen.swift
//  Job4m2
//
//  Created by Danil Dubov on 03.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI
import Foundation

struct SexScreen: View {
    @ObservedObject var controller: SexController

    var body: some View {
        ZStack {
            makeCard(with: controller.index + 1)
            makeCard(with: controller.index)
        }
        .padding()
        .onAppear {
            controller.onAppear()
        }
    }

    @ViewBuilder
    func makeCard(with index: Int) -> some View {
        if controller.cards.count > 0 {
            CardView(model: controller.cards[index % controller.cards.count])
                .id(controller.cards[index % controller.cards.count].id)
        } else {
            ProgressView().progressViewStyle(.circular)
        }
    }
}

struct SexScreen_Previews: PreviewProvider {
    static var previews: some View {
        SexScreen(controller: SexController())
    }
}
