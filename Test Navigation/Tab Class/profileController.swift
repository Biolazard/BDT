//
//  settingController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 16/11/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class profileController: UIViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(r: 22, g: 147, b: 162)
        navigationItem.title = "Profilo"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }
    
    @objc func handleLogout()
    {
        do
        {
            try Auth.auth().signOut()
            present(loginController(), animated: false, completion: nil)
        } catch { debugPrint(error.localizedDescription)}
        
        
    }
    
}
