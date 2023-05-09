//
//  TabBarController.swift
//  Kreamish
//
//  Created by 안종표 on 2023/05/09.
//

import UIKit

final class TabBarController: UITabBarController {
    private lazy var HomeViewController: UIViewController = {
        let viewController = UIViewController()
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let normalImage = UIImage(systemName: "house", withConfiguration: imageConfiguration)
        let selectedImage = UIImage(systemName: "house.fill", withConfiguration: imageConfiguration)
        let tabBarItem = UITabBarItem(title: "HOME", image: normalImage, tag: 0)
        tabBarItem.selectedImage = selectedImage
        viewController.tabBarItem = tabBarItem
            
        return viewController
    }()
    
    private lazy var ShopViewController: UIViewController = {
        let viewController = UIViewController()
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let normalImage = UIImage(systemName: "magnifyingglass.circle", withConfiguration: imageConfiguration)
        let selectedImage = UIImage(systemName: "magnifyingglass.circle.fill", withConfiguration: imageConfiguration)
        let tabBarItem = UITabBarItem(title: "SHOP", image: normalImage, tag: 1)
        tabBarItem.selectedImage = selectedImage
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    private lazy var MyViewController: UIViewController = {
        let viewController = UIViewController()
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let normalImage = UIImage(systemName: "person", withConfiguration: imageConfiguration)
        let selectedImage = UIImage(systemName: "person.fill", withConfiguration: imageConfiguration)
        let tabBarItem = UITabBarItem(title: "MY", image: normalImage, tag: 2)
        tabBarItem.selectedImage = selectedImage
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

private extension TabBarController{
    func configureUI(){
        self.viewControllers = [HomeViewController, ShopViewController, MyViewController]
        self.tabBar.tintColor = .black
    }
}
