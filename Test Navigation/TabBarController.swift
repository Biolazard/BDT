//
//  tabBarController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 16/11/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController
{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createTab(viewController: searchController(), name: "Cerca", image: UIImage(named: "search")), createTab(viewController: addController(), name: "Inserisci", image: UIImage(named: "add")), createTab(viewController: serviceController(), name: "Servizi", image: UIImage(named: "service")), createTab(viewController: profileController(), name: "Profilo", image: UIImage(named: "user"))]
        
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        tabBar.tintColor = UIColor(r: 22, g: 147, b: 162)
        
    }

    
    
    private func createTab(viewController: UIViewController, name: String, image: UIImage?) -> UINavigationController
    {
        let viewController = viewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = name
        navController.tabBarItem.image = image
        
        return navController
    }
    
}
