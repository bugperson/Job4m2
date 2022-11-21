//
//  AuthCoordinator.swift
//  Job4m2
//
//  Created by Danil Dubov on 06.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class AuthCoordinator {

    var onFinishEvent: Action?
    var onRegister: Action?

    let container: UINavigationController

    init(container: UINavigationController) {
        self.container = container
    }

    func start() {
        let controller = AuthController()
        let vc = AuthView(controller: controller).hosted()
        vc.modalPresentationStyle = .fullScreen
        container.setViewControllers([vc], animated: true)
        controller.onEnter = {
            self.onFinishEvent?()
        }
        controller.onRegistrationButtonTapped = onRegister
    }
}
