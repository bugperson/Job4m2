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

    private var sexCoordinator: SexCoordinator?

    init(container: UINavigationController) {
        self.container = container
    }

    func start() {
        let controller = RegistrationController()
        controller.onFinishEvent = openSexScreen
        let x = RegistrationView(controller: controller).hosted()
        x.modalPresentationStyle = .fullScreen
        container.setViewControllers([x], animated: false)
    }

    func openSexScreen() {
        let sexCoordinator = SexCoordinator(container: self.container)
        sexCoordinator.start()
        self.sexCoordinator = sexCoordinator
    }
}
