import Foundation
import UIKit

class AppCoordinator {

    private let window: UIWindow
    private let container: UINavigationController = {
        let container = UINavigationController()
        container.modalPresentationStyle = .fullScreen
        return container
    }()
    private let a = AuthService()

    private var registrationCoordinator: RegistrationCoordinator?
    private var sexCoordinator: SexCoordinator?

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        makeRootViewController(container)
    }

    func start() {
//        let registrationCoordinator = RegistrationCoordinator(container: container)
//        registrationCoordinator.start()
//        self.registrationCoordinator = registrationCoordinator

        let sexCoordinator = SexCoordinator(container: container)
        sexCoordinator.start()
        self.sexCoordinator = sexCoordinator
    }

    private func makeRootViewController(_ vc: UIViewController) {
        window.rootViewController = vc
        window.makeKeyAndVisible()
        a.auth(parameters: AuthParameters(username: "123", password: "123"))
    }
}
