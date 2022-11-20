//
//  ProfileRouter.swift
//  Job4m2
//
//  Created by Danil Dubov on 20.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator {
    var onFinishEvent: Action?
    let container: UIViewController

    init(container: UIViewController) {
        self.container = container
    }

    func start() {
        let controller = ProfileController()
        let vc = ProfileView(controller: controller).hosted()
        vc.modalPresentationStyle = .fullScreen
        container.present(vc, animated: false)
    }
}
