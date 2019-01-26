//
//  detailPostSearch.swift
//  Test Navigation
//
//  Created by Marius Lazar on 25/01/2019.
//  Copyright © 2019 Marius Lazar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
    
    lazy var lblProposte: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.text = "Proposte"
        lbl.alpha = 0
        return lbl
    }()
    
    lazy var imgProposta: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.alpha = 0
        img.isUserInteractionEnabled = true
        return img
    }()
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    let userID = Auth.auth().currentUser!.uid
    var postInt: Int? 
    var proposte: String?
    {
        didSet
        {
            switch proposte
            {
            case "RtvEIHrdBXWfddMLletlSDbMqcc2":
                imgProposta.image = UIImage(named: "RtvEIHrdBXWfddMLletlSDbMqcc2")
                if userID != "RtvEIHrdBXWfddMLletlSDbMqcc2"
                {
                    imgProposta.alpha = 1
                }
                
                
            case "PtXGYG1Qx7gheDkehkiZmJAaOuy1":
                imgProposta.image = UIImage(named: "PtXGYG1Qx7gheDkehkiZmJAaOuy1")
                if userID != "PtXGYG1Qx7gheDkehkiZmJAaOuy1"
                {
                    imgProposta.alpha = 1
                }
                
            default:
                lblProposte.text = "Nessuna proposta".uppercased()
                lblProposte.textColor = .red
            }
            
            
            
        }
    }
    var uidUserBoss: String?
    {
        didSet
        {
            if uidUserBoss == userID
            {
                btnInviaRichiesta.alpha = 0
                lblProposte.alpha = 1
            }
        }
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
        view.addSubview(lblProposte)
        view.addSubview(imgProposta)
        
        let gestureAdd = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        imgProposta.addGestureRecognizer(gestureAdd)
        
        configureConstraints()
    }
    
    @objc func openProfile()
    {
        
        var titoloNav = ""
        switch self.proposte
        {
        case "RtvEIHrdBXWfddMLletlSDbMqcc2":
            titoloNav = "Elon Musk"
            
        case "PtXGYG1Qx7gheDkehkiZmJAaOuy1":
            titoloNav = "Steve Jovs"
            
        default:
            titoloNav = "Elon Musk"
        }
        let newProfile = openedProfile()
        newProfile.title = titoloNav
        newProfile.idProfile = self.proposte
        newProfile.postInt = self.postInt
        if lblProposte.text == "Assegnato a"
        {
            newProfile.btnAccetta.alpha = 0
            newProfile.btnRifiuta.alpha = 0
        }
        self.navigationController?.pushViewController(newProfile, animated: true)
    }
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")
    
    @objc func handleInviaRichiesta()
    {
        self.view.showBlurLoader()
        let postToAdd = self.dataBase.child("Post").child("\(self.postInt ?? 0)")
        let newPost = ["proposte": self.userID] as [String : Any]
        
        postToAdd.updateChildValues(newPost as [AnyHashable : Any], withCompletionBlock:
            { (error, response) in
                if error != nil
                {
                    debugPrint("errore")
                    self.view.removeBluerLoader()
                }
                else
                {
                    self.view.removeBluerLoader()
                    self.navigationController?.popViewController(animated: true)
                    
                }
        })
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
        
        lblProposte.topAnchor.constraint(equalTo: lblTextLuogo.bottomAnchor, constant: 16).isActive = true
        lblProposte.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lblProposte.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imgProposta.topAnchor.constraint(equalTo: lblProposte.bottomAnchor, constant: 8).isActive = true
        imgProposta.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgProposta.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgProposta.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    

}
