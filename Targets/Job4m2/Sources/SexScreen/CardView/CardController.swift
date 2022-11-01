//
//  CardController.swift
//  Job4m2
//
//  Created by Danil Dubov on 01.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import SwiftUI

final class CardController: ObservableObject {

    @Published var imagePath: String = ""
    @Published var title: String = ""
    @Published var description: String = ""


    public func onAppear() {
        title = "Азамат, 23"
        description = "ака DJ люблю овечек"
    }
}
