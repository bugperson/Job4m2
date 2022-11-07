import Foundation
import UIKit

final class SetupCoordinator {

    let authService = AuthService()

    var onFinishEvent: Action?
    let container: UINavigationController

    var registrationCoordinator: RegistrationCoordinator?
//    var loginCoordinator: LoginCoordinator?
//    var onboardingCoordinator: OnboardingCoordinator?

    init(container: UINavigationController) {
        self.container = container
    }

    func start() {
        guard !authService.isLoggedIn else {
            onFinishEvent?()
            return
        }

        showRegistration()
    }

    private func showRegistration() {
        let registrationCoordinator = RegistrationCoordinator(container: container)
        self.registrationCoordinator = registrationCoordinator
        registrationCoordinator.onFinishEvent = { [weak self] in
            guard let self = self else { return }

            self.registrationCoordinator = nil
            self.onFinishEvent?()
        }

        registrationCoordinator.start()
    }
}
