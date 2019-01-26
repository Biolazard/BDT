//
//  openedProfile.swift
//  Test Navigation
//
//  Created by Marius Lazar on 26/01/2019.
//  Copyright © 2019 Marius Lazar. All rights reserved.
//

import UIKit

class openedProfile: UIViewController {

    lazy var lblColor: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = UIColor(r: 22, g: 147, b: 162)
        return lbl
    }()
    
    lazy var imgProfile: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    //Devo completare lbl nome e aggiungere le stelle
    lazy var lblNome: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
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
        configureConstraints()
    }
    
    func configureConstraints()
    {
        lblColor.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        lblColor.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lblColor.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        imgProfile.centerYAnchor.constraint(equalTo: lblColor.centerYAnchor).isActive = true
        imgProfile.leftAnchor.constraint(equalTo: lblColor.leftAnchor, constant: 16).isActive = true
        imgProfile.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgProfile.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

}
