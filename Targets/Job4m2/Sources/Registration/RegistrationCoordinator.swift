import Foundation
import SwiftUI
import UIKit
import Combine

typealias Action = () -> Void

extension View {
    func hosted() -> UIHostingController<Self> {
        return UIHostingController(rootView: self)
    }
}

final class RegistrationCoordinator {

    var onFinishEvent: Action?
    let container: UINavigationController

    init(container: UINavigationController) {
        self.container = container
    }

    func start() {
        let controller = RegistrationController()
        let hostedController = RegistrationView(controller: controller).hosted()

        hostedController.modalPresentationStyle = .fullScreen
        container.setViewControllers([hostedController], animated: false)
        controller.onRegistrationFinish = {
            print("hui")
            self.onFinishEvent?()
        }
    }
}
