import UIKit

struct FeedDTO: Decodable {
    
}

class VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let route = APIRoute(route: Route.User.feed.asPath, method: .get)
    }
}
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
