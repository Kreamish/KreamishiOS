//
//  SceneDelegate.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var statusBarView = UIView()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        statusBarView.frame =  window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
    }

    


}

