//
//  feedbackController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 27/01/2019.
//  Copyright © 2019 Marius Lazar. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseAuth
import FirebaseDatabase

class feedbackController: UIViewController {

    lazy var cosmos: CosmosView = {
        var cosmos = CosmosView()
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        cosmos.settings.totalStars = 5
        cosmos.rating = 3
        return cosmos
    }()
    
    lazy var lblSelectStars: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.text = "Scegli quante stelle assegnare"
        return lbl
    }()
    
    lazy var txtFeedback: UITextView = {
        var txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.layer.borderWidth = 0.3
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.cornerRadius = 8
        return txt
    }()
    
    lazy var btnSendFeedback: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Invia", for: .normal)
        btn.backgroundColor = UIColor(r: 252, g: 179, b: 48)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .boldSystemFont(ofSize: 28)
        btn.contentHorizontalAlignment = .center
        btn.addTarget(self, action: #selector(sendFeedback), for: .touchUpInside)
        return btn
    }()
    
    var numberStars: Double?
    var postInt: Int?
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feedback"
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.addSubview(cosmos)
        view.addSubview(txtFeedback)
        view.addSubview(lblSelectStars)
        view.addSubview(btnSendFeedback)
        
        numberStars = cosmos.rating
        cosmos.didTouchCosmos = { rating in
            self.numberStars = rating
            debugPrint(rating)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismssKeyboard))
        view.addGestureRecognizer(tap)
        
        
        configureConstraints()
    }
    let userID = Auth.auth().currentUser!.uid
    var idBoss: String?
    @objc func sendFeedback()
    {
        self.view.showBlurLoader()
        
        var postToAdd: DatabaseReference
        switch self.userID {
        case "PtXGYG1Qx7gheDkehkiZmJAaOuy1":
            postToAdd = self.dataBase.child("Utenti").child("RtvEIHrdBXWfddMLletlSDbMqcc2").child("feedback").child("\(self.postInt ?? 0)")
        default:
            postToAdd = self.dataBase.child("Utenti").child("PtXGYG1Qx7gheDkehkiZmJAaOuy1").child("feedback").child("\(self.postInt ?? 0)")
        }
        
        let newPost = ["numero stelle": self.numberStars!, "descrizione": self.txtFeedback.text, ] as [String : Any]
        let boolFeedback: [String : Any]
        
        if self.userID == self.idBoss
        {
             boolFeedback = ["feedback rilasciato boss": "true"] as [String : Any]
        }
        else
        {
             boolFeedback = ["feedback rilasciato helper": "true"] as [String : Any]
        }
        
        
        let feed = self.dataBase.child("Post").child("\(self.postInt ?? 0)")
        feed.updateChildValues(boolFeedback as [AnyHashable : Any]) { (error, respose) in
            if error != nil
            {
                debugPrint("errore")
            }
        }
        
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
    
    @objc func handleDismssKeyboard()
    {
        view.endEditing(true)
    }
    
    func configureConstraints()
    {
        lblSelectStars.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 32).isActive = true
        lblSelectStars.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        cosmos.topAnchor.constraint(equalTo: lblSelectStars.bottomAnchor, constant: 8).isActive = true
        cosmos.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        txtFeedback.topAnchor.constraint(equalTo: cosmos.bottomAnchor, constant: 16).isActive = true
        txtFeedback.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtFeedback.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56).isActive = true
        txtFeedback.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        btnSendFeedback.topAnchor.constraint(equalTo: txtFeedback.bottomAnchor, constant: 32).isActive = true
        btnSendFeedback.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnSendFeedback.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
}
