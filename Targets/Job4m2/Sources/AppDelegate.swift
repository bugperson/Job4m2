import UIKit
import Job4m2Kit
import Job4m2UI

struct FeedDTO: Decodable {
    
}

class VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let route = APIRoute(route: Route.User.feed.asPath, method: .get)
        Task {
            let x: FeedDTO? = await APIService.z.perform(route: route)
            print(x!)
        }
    }
}
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = VC()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        Job4m2Kit.hello()
        Job4m2UI.hello()
        
        return true
    }

}
