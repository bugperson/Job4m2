import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
       
        let appCoordinator = AppCoordinator()
        self.appCoordinator = appCoordinator
        appCoordinator.start()

        return true
    }

}
