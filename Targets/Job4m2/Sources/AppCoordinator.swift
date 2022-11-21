import Foundation
import UIKit

final class Zalupa {
    static var a: ((Deeplinks) -> Void)?
}

class AppCoordinator {

    private let window: UIWindow
    private let container: UINavigationController = {
        let container = UINavigationController()
        container.isNavigationBarHidden = true
        return container
    }()

    private var setupCoordinator: SetupCoordinator?
    private var sexCoordinator: SexCoordinator?

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        makeRootViewController(container)
    }

    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        makeRootViewController(container)
    }

    func start() {
        let setupCoordinator = SetupCoordinator(container: container)
        self.setupCoordinator = setupCoordinator
        setupCoordinator.onFinishEvent = { [weak self] in
            guard let self = self else { return }
            self.setupCoordinator = nil
            self.startFeed()
        }

        setupCoordinator.start()
    }

    private func startFeed() {
        let sexCoordinator = SexCoordinator(container: container)
        self.sexCoordinator = sexCoordinator
        sexCoordinator.start()
    }

    func openDeeplink(deeplink: Deeplinks) {
        switch deeplink {
        case .matchscreen:
            sexCoordinator?.openDeeplink(deeplink: deeplink)
        }
    }

    private func makeRootViewController(_ vc: UIViewController) {
        Zalupa.a = openDeeplink(deeplink:)
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
