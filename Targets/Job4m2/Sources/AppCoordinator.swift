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

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        makeRootViewController(container)
    }

    func start() {
        let registrationCoordinator = RegistrationCoordinator(container: container)
//        registrationCoordinator.start()
        if a.token != nil { // затычка просто похуй пока что
            registrationCoordinator.openSexScreen()
        } else {
            registrationCoordinator.start()
            self.registrationCoordinator = registrationCoordinator
        }
    }

    private func makeRootViewController(_ vc: UIViewController) {
        window.rootViewController = vc
        window.makeKeyAndVisible()
//        a.auth(parameters: AuthParameters(username: "Test", password: "Test"))
//        a.refreshToken()
    }
}
