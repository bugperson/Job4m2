//
//  SexScreen.swift
//  Job4m2
//
//  Created by Danil Dubov on 03.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct SexScreen: View {
    @ObservedObject var controller: SexController

    var body: some View {
        ZStack {
            ForEach(controller.cards, id: \.id) { card in
                CardView(model: card)
            }
        }.onAppear {
            controller.onAppear()
        }
    }
}

struct SexScreen_Previews: PreviewProvider {
    static var previews: some View {
        SexScreen(controller: SexController())
    }
}
