//
//  LikesCoordinator.swift
//  Job4m2
//
//  Created by Danil Dubov on 07.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import UIKit

final class LikesCoordinator {

    var onFinishEvent: Action?
    let container: UINavigationController

    init(container: UINavigationController) {
        self.container = container
    }

    func start() {
        let controller = LikesController()
        let x = LikesView(controller: controller).hosted()
        x.modalPresentationStyle = .formSheet
        container.setViewControllers([x], animated: false)
    }
}
