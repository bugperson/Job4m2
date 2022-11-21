//
//  SceneDelegate.swift
//  Job4m2
//
//  Created by fff on 21.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?

    //Deeplink or Universial Link Open when app is start.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        UIApplication.shared.delegate = self
        if let userActivity = connectionOptions.userActivities.first,
           userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let urlinfo = userActivity.webpageURL{
            fatalError()
            print ("Universial Link Open at SceneDelegate on App Start ::::::: \(urlinfo)")

        }

        //deeplink Open
        if connectionOptions.urlContexts.first?.url != nil {
          let urlinfo = connectionOptions.urlContexts.first?.url
            fatalError()
            print ("Deeplink Open at SceneDelegate on App Start ::::::: \(String(describing: urlinfo))")


        }

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let appCoordinator = AppCoordinator(scene: windowScene)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }

//     Universial link Open when app is onPause
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let urlinfo = userActivity.webpageURL{
            fatalError()
            print ("Universial Link Open at SceneDelegate on App Pause  ::::::: \(urlinfo)")
            
        }
    }
    
    // Deeplink Open when app in onPause
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        let urlinfo = URLContexts.first?.url
        fatalError()
        print ("Deeplink Open on SceneDelegate at App Pause :::::::: \(String(describing: urlinfo))")

    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        
        Task {
            let a: A? = await APIService.shared.perform(
                route: APIRoute(route: Route.User.apns.asPath, method: .post),
                parameters: AnusDTO(token: token)
            )
        }
        print("Device Token: \(token)")
    }
}
