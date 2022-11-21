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
    let container: UIViewController

    init(container: UIViewController) {
        self.container = container
    }

    func start() {
        let controller = LikesController()
        let vc = LikesView(controller: controller).hosted()
        vc.modalPresentationStyle = .formSheet
        container.present(vc, animated: false)
    }

    func start(with deeplink: Deeplinks) {
        let controller = LikesController()
        switch deeplink {
        case .matchscreen(let int):
            controller.startWithCardId = int
        }
        let vc = LikesView(controller: controller).hosted()
        vc.modalPresentationStyle = .formSheet
        container.present(vc, animated: false)
    }
}
