//
//  UIViewController+StatusBar.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/11.
//

import UIKit

extension UIViewController {
    var statusBar: UIView? {
        //status bar design  scene는 싱글톤 느낌으로 같이 사용가능
        //scenedelegate 접근
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        if let hasStatusBar = sceneDelegate?.statusBarView {
            window?.addSubview(hasStatusBar)
        }
        return sceneDelegate?.statusBarView
    }
}
