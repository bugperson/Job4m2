import UIKit

enum Deeplinks {

    case matchscreen(Int)
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var appCoordinator: AppCoordinator?
    
    let apiService = APIService()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
//        let appCoordinator = AppCoordinator()
//        self.appCoordinator = appCoordinator
//        appCoordinator.start()
//        launchOptions?.forEach { print($0) }
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("hui1")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        handleUserInfo(userInfo: userInfo)
    }

    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        defer { completionHandler(.noData)}
        handleUserInfo(userInfo: userInfo)
    }

    func handleUserInfo(userInfo: [AnyHashable : Any]) {
        guard let str = userInfo["url"] as? String else { return }
        guard let url = URL(string: str) else { return }
        guard url.scheme == "job4mscheme" else { return }

        print(url.path)
        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )!

        var id: Int?
        print(components.queryItems?.forEach { hui in
            
            id = Int(hui.value ?? "")
        })
        guard let idd = id else { return }
        Zalupa.a?(.matchscreen(idd))
    }
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        
        Task {
            let a: A? = await apiService.perform(
                route: APIRoute(route: Route.User.apns.asPath, method: .post),
                parameters: AnusDTO(token: token)
            )
        }
        print("Device Token: \(token)")
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("Пизда")
        if let scheme = url.scheme,
           scheme.localizedCaseInsensitiveCompare("job4mscheme") == .orderedSame,
           let view = url.host {
            
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            print(parameters)
            
        }
        return true
    }
}

struct A: Decodable { }
struct AnusDTO: Encodable {
    let token: String
}
