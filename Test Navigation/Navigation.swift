//
//  Navigation.swift
//  Test Navigation
//
//  Created by Marius Lazar on 13/11/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Navigation: UINavigationController
{
    
    override func viewDidLoad()
    {
        
        
        if Auth.auth().currentUser?.uid != nil
        {
            let appDeleagate = UIApplication.shared.delegate as! AppDelegate
            appDeleagate.window?.makeKeyAndVisible()
            appDeleagate.window?.rootViewController = TabBarController()
        }
        else
        {
            self.pushViewController(loginController(), animated: false)
        }
    }


}
