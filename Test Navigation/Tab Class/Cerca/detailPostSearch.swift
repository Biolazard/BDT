//
//  detailPostSearch.swift
//  Test Navigation
//
//  Created by Marius Lazar on 25/01/2019.
//  Copyright © 2019 Marius Lazar. All rights reserved.
//

import UIKit

class detailPostSearch: UIViewController {

    lazy var lblDescrizione: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .white
        lbl.font = .systemFont(ofSize: 20)
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 0
        lbl.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        lbl.layer.borderColor = UIColor.lightGray.cgColor
        lbl.layer.cornerRadius = 8
        return lbl
    }()
    
    lazy var lblValore: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.text = "Compenso"
        return lbl
    }()
    
    lazy var lblOreMinuti: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 0
        lbl.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        lbl.layer.borderColor = UIColor.lightGray.cgColor
        lbl.layer.cornerRadius = 8
        return lbl
    }()
    
    lazy var lblLuogo: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.text = "Luogo"
        return lbl
    }()
    
    lazy var lblTextLuogo: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 0
        lbl.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        lbl.layer.borderColor = UIColor.lightGray.cgColor
        lbl.layer.cornerRadius = 8
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var btnInviaRichiesta: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Invia richiesta", for: .normal)
        btn.backgroundColor = UIColor(r: 22, g: 147, b: 162)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .boldSystemFont(ofSize: 28)
        btn.contentHorizontalAlignment = .center
        btn.addTarget(self, action: #selector(handleInviaRichiesta), for: .touchUpInside)
        return btn
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(r: 22, g: 147, b: 162)
        
        view.addSubview(lblDescrizione)
        view.addSubview(lblValore)
        view.addSubview(lblOreMinuti)
        view.addSubview(btnInviaRichiesta)
        view.addSubview(lblLuogo)
        view.addSubview(lblTextLuogo)
        configureConstraints()
    }
    
    @objc func handleInviaRichiesta()
    {
        debugPrint("hello")
    }
    
    func configureConstraints()
    {
        lblDescrizione.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 16).isActive = true
        lblDescrizione.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblDescrizione.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        lblDescrizione.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        lblValore.topAnchor.constraint(equalTo: lblDescrizione.bottomAnchor, constant: 16).isActive = true
        lblValore.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lblValore.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        lblOreMinuti.topAnchor.constraint(equalTo: lblValore.bottomAnchor, constant: 8).isActive = true
        lblOreMinuti.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -250).isActive = true
        lblOreMinuti.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        lblLuogo.topAnchor.constraint(equalTo: lblOreMinuti.bottomAnchor, constant: 16).isActive = true
        lblLuogo.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lblLuogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        lblTextLuogo.topAnchor.constraint(equalTo: lblLuogo.bottomAnchor, constant: 8).isActive = true
        lblTextLuogo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -120).isActive = true
        lblTextLuogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        btnInviaRichiesta.topAnchor.constraint(equalTo: lblTextLuogo.bottomAnchor, constant: 32).isActive = true
        btnInviaRichiesta.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnInviaRichiesta.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56).isActive = true
        
    }
    
    

}
