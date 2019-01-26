//
//  openedProfile.swift
//  Test Navigation
//
//  Created by Marius Lazar on 26/01/2019.
//  Copyright © 2019 Marius Lazar. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseAuth
import FirebaseDatabase

class openedProfile: UIViewController {

    lazy var lblColor: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = UIColor(r: 22, g: 147, b: 162)
        lbl.isEnabled = true
        return lbl
    }()
    
    lazy var imgProfile: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var cosmosView: CosmosView = {
        var cosmos = CosmosView()
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        cosmos.settings.updateOnTouch = false
        cosmos.settings.textColor = .white
        cosmos.settings.totalStars = 5
        cosmos.rating = 4
        cosmos.settings.filledColor = .white
        cosmos.settings.filledBorderColor = .white
        cosmos.settings.emptyBorderColor = .white
        return cosmos
    }()
    
    lazy var btnAccetta: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Accetta", for: .normal)
        btn.backgroundColor = UIColor(r: 59, g: 166, b: 38)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.contentHorizontalAlignment = .center
        btn.addTarget(self, action: #selector(handleAccetta), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnRifiuta: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Rifiuta", for: .normal)
        btn.backgroundColor = UIColor(r: 238, g: 50, b: 40)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.contentHorizontalAlignment = .center
        btn.isEnabled = true
        btn.addTarget(self, action: #selector(handleRifiuta), for: .touchUpInside)
        return btn
    }()
    
    var idProfile: String?
    {
        didSet
        {
            imgProfile.image = UIImage(named: idProfile!)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lblColor)
        
        lblColor.addSubview(imgProfile)
        lblColor.addSubview(cosmosView)
        view.addSubview(btnAccetta)
        view.addSubview(btnRifiuta)
        configureConstraints()
    }
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")
    var postInt: Int?
    
    @objc func handleAccetta()
    {
        self.view.showBlurLoader()
        let postToAdd = self.dataBase.child("Post").child("\(self.postInt ?? 0)")
        let newPost = ["post assegnato": "true"] as [String : Any]
        
        postToAdd.updateChildValues(newPost as [AnyHashable : Any], withCompletionBlock:
            { (error, response) in
                if error != nil
                {
                    self.view.removeBluerLoader()
                }
                else
                {
                    self.view.removeBluerLoader()
                    self.navigationController?.popToRootViewController(animated: true)
                }
        })
    }
    
    @objc func handleRifiuta()
    {
        debugPrint("hello")
        self.view.showBlurLoader()
        let postToAdd = self.dataBase.child("Post").child("\(self.postInt ?? 0)")
        let newPost = ["proposte": ""] as [String : Any]
        
        postToAdd.updateChildValues(newPost as [AnyHashable : Any], withCompletionBlock:
            { (error, response) in
                if error != nil
                {
                    self.view.removeBluerLoader()
                }
                else
                {
                    self.view.removeBluerLoader()
                    self.navigationController?.popToRootViewController(animated: true)
                }
        })
    }
    
    func configureConstraints()
    {
        lblColor.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        lblColor.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lblColor.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lblColor.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        imgProfile.centerYAnchor.constraint(equalTo: lblColor.centerYAnchor).isActive = true
        imgProfile.leftAnchor.constraint(equalTo: lblColor.leftAnchor, constant: 16).isActive = true
        imgProfile.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgProfile.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        cosmosView.leftAnchor.constraint(equalTo: imgProfile.rightAnchor, constant: 16).isActive = true
        cosmosView.centerYAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: -32).isActive = true
        
        btnAccetta.leftAnchor.constraint(equalTo: imgProfile.rightAnchor, constant: 16).isActive = true
        btnAccetta.centerYAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: 32).isActive = true
        btnAccetta.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        btnRifiuta.leftAnchor.constraint(equalTo: btnAccetta.rightAnchor, constant: 8).isActive = true
        btnRifiuta.centerYAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: 32).isActive = true
        btnRifiuta.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
    }

}
