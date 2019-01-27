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

class openedProfile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

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
        cosmos.settings.fillMode = .precise
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
    
    let cellID = "cellProf"
    
    lazy var myTable: UITableView = {
        var tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.delegate = self
        tbl.dataSource = self
        tbl.rowHeight = 200
        tbl.register(feedbackCell.self, forCellReuseIdentifier: cellID)
        return tbl
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
        view.addSubview(myTable)
        downloadArray()
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
    
    var jsonFeedback: [infoUsers] = []
    @objc func downloadArray()
    {
        dataBase.child("Utenti").child(idProfile!).child("feedback").observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any]
            {
                self.view.removeBluerLoader()
                var fetchArray: [infoUsers] = []
                for element in dictionary
                {
                    
                    let value = element.value as? [String: Any]
                    
                    let post = infoUsers(stars: value?["numero stelle"] as? Double, descrizione: value?["descrizione"] as? String)
                    fetchArray.append(post)
                    
                    
                }
                self.jsonFeedback = fetchArray
                self.myTable.reloadData()
                
            }
            else
            {
                self.view.removeBluerLoader()
                debugPrint("errore")
            }
        }
    }
    
    @objc func handleRifiuta()
    {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "FEEDBACK"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonFeedback.count
    }
    
    let userID = Auth.auth().currentUser!.uid
    var totalStart: [Double] = []
    {
        didSet
        {
            var tot = 0.0
            for value in totalStart
            {
                tot = tot + value
            }
            tot = tot/Double(totalStart.count)
            cosmosView.rating = tot
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! feedbackCell
        let post = jsonFeedback[indexPath.row]
        cell.descrizione.text = post.descrizione
        cell.start.rating = post.stars!
        totalStart.append(post.stars!)
        cell.imageFeedback.image = UIImage(named: self.userID)
        return cell
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
        
        btnRifiuta.leftAnchor.constraint(equalTo: imgProfile.rightAnchor, constant: 16).isActive = true
        btnRifiuta.centerYAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: 32).isActive = true
        btnRifiuta.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        btnAccetta.leftAnchor.constraint(equalTo: btnRifiuta.rightAnchor, constant: 8).isActive = true
        btnAccetta.centerYAnchor.constraint(equalTo: imgProfile.centerYAnchor, constant: 32).isActive = true
        btnAccetta.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        myTable.topAnchor.constraint(equalTo: lblColor.bottomAnchor).isActive = true
        myTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        myTable.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
    }

}
