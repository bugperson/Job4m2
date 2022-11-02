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
    let container: UIViewController

    init(container: UIViewController) {
        self.container = container
    }

    func start() {
        let controller = SexController()
        let vc = SexScreen(controller: controller).hosted()
        vc.modalPresentationStyle = .fullScreen
        container.present(vc, animated: false)
    }
}
