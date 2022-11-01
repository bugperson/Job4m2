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
    let container: UIViewController

    init(container: UIViewController) {
        self.container = container
    }

    func start() {
        let controller = RegistrationController()
//        let x = RegistrationView(controller: controller).hosted()
        let x = CardView(controller: CardController()).hosted()
        x.modalPresentationStyle = .fullScreen
        container.present(x, animated: false)
    }
}
