//
//  SexCoordinator.swift
//  Job4m2
//
//  Created by Danil Dubov on 03.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class SexCoordinator {

    var onFinishEvent: Action?
    let container: UINavigationController

    private var likesCoordinator: LikesCoordinator?
    private var registrationCoordinator: RegistrationCoordinator?

    private let authService = AuthService()

    init(container: UINavigationController) {
        self.container = container
    }

    func start() {
        let controller = SexController()

        controller.openLikes = openLikes
        controller.exit = exit

        let vc = SexScreen(controller: controller).hosted()
        vc.view.backgroundColor = .gray
        vc.modalPresentationStyle = .fullScreen
        container.setViewControllers([vc], animated: false)
    }

    func openLikes() {
        let likesCoordinator = LikesCoordinator(container: container)
        self.likesCoordinator = likesCoordinator
        likesCoordinator.start()
    }

    func exit() {
        authService.logout()
        fatalError()
    }
}
