//
//  serviceController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 25/01/2019.
//  Copyright © 2019 Marius Lazar. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseDatabase

class serviceController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let segmentControl: UISegmentedControl = {
        var sc = UISegmentedControl()
        let item = ["RICHIESTI", "FORNITI", "ACCETTATI"]
        sc = UISegmentedControl(items: item)
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        sc.layer.borderColor = UIColor(r: 22, g: 147, b: 162).cgColor
        sc.layer.borderWidth = 1
        sc.translatesAutoresizingMaskIntoConstraints = false
        let attributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        let attributesSelected = [NSAttributedString.Key.foregroundColor: UIColor(r: 22, g: 147, b: 162), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        sc.setTitleTextAttributes(attributesNormal, for: .normal)
        sc.setTitleTextAttributes(attributesSelected, for: .selected)
        sc.addTarget(self, action: #selector(handleROA), for: .valueChanged)
        return sc
    }()
    
    let cellID = "cellROA"
    
    lazy var myTable: UITableView = {
        var tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.delegate = self
        tbl.dataSource = self
        tbl.rowHeight = 100
        tbl.register(FoaCell.self, forCellReuseIdentifier: cellID)
        return tbl
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(r: 22, g: 147, b: 162)
        navigationItem.title = "Servizi"
        
        view.addSubview(segmentControl)
        view.addSubview(myTable)
        downloadArray()
        configureConstraints()
    }
    
    func configureConstraints()
    {
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        myTable.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 1).isActive = true
        myTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        myTable.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
    }
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")
    var jsonDownloaded: [download] = []
    var jsonRichiesti: [download] = []
    var jsonOfferti: [download] = []
    var jsonAccettati: [download] = []
    
    let userID = Auth.auth().currentUser!.uid
    
    func downloadArray()
    {
        dataBase.child("Post").observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any]
            {
                self.view.removeBluerLoader()
                var jsonR: [download] = []
                var jsonO: [download] = []
                var jsonA: [download] = []
                for element in dictionary
                {
                    let value = element.value as? [String: Any]
                    let post = download(cambioOra: self.castToBool(value: value?["cambio ora"] as? String), categoria: value!["categoria"] as? String, descrizione: value?["descrizione"] as? String, feedbackRilasciato: self.castToBool(value: value?["feedback rilasciato"] as? String), luogo: value?["luogo"] as? String, minuti: value?["minuti"] as? Int, ore: value?["ore"] as? Int, postAssegnato: self.castToBool(value: value?["post assegnato"] as? String), terminaDaBoss: self.castToBool(value: value?["termina da boss"] as? String), richiestaofferta: value?["richiestaofferta"] as? String, terminaDaUtente: self.castToBool(value: value?["termina utente help"] as? String), titolo: value?["titolo"] as? String, idBoss: value?["utente boss"] as? String, idPost: value?["idPost"] as? Int, proposte: value?["proposte"] as? String)
                    
                    if post.idBoss == self.userID && post.richiestaofferta == "fornisce"
                    {
                        jsonO.append(post)
                    }
                    
                    if post.idBoss == self.userID && post.richiestaofferta == "richiede"
                    {
                        jsonR.append(post)
                    }
                    
                    if post.idBoss != self.userID && post.postAssegnato == true
                    {
                        jsonA.append(post)
                    }
                    
                }
                self.jsonOfferti = jsonO
                self.jsonRichiesti = jsonR
                self.jsonAccettati = jsonA
                
                self.myTable.reloadData()
                
            }
            else
            {
                
                debugPrint("errore")
            }
        }
    }
    
    func castToBool (value: String?) -> Bool? {
        let string = value?.lowercased()
        
        switch string {
        case "false":
            return false
        case "true":
            return true
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            return jsonRichiesti.count
        case 1:
            return jsonOfferti.count
        default:
            return jsonAccettati.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FoaCell
        
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            
            let post = jsonRichiesti[indexPath.row]
            cell.lblTitolo.text = post.titolo
            if post.postAssegnato == true
            {
                cell.imageProposte.image = UIImage(named: post.richiestaofferta!)
                cell.lblProposteOInCorso.text = "In corso...".uppercased()
                cell.lblProposteOInCorso.textColor = UIColor(r: 22, g: 147, b: 162)
            }
            else
            {
                cell.lblProposteOInCorso.text = "Non ancora assegnato".uppercased()
                cell.lblProposteOInCorso.textColor = .red
            }
            
        case 1:
            let post = jsonOfferti[indexPath.row]
            cell.lblTitolo.text = post.titolo
            if post.postAssegnato == true
            {
                cell.imageProposte.image = UIImage(named: post.richiestaofferta!)
                cell.lblProposteOInCorso.text = "In corso...".uppercased()
                cell.lblProposteOInCorso.textColor = UIColor(r: 22, g: 147, b: 162)
            }
            else
            {
                cell.lblProposteOInCorso.text = "Non ancora assegnato".uppercased()
                cell.lblProposteOInCorso.textColor = .red
            }
            
        default:
            let post = jsonAccettati[indexPath.row]
            cell.lblTitolo.text = post.titolo
            if post.postAssegnato == true
            {
                cell.imageProposte.image = UIImage(named: post.richiestaofferta!)
                cell.lblProposteOInCorso.text = "In corso...".uppercased()
                cell.lblProposteOInCorso.textColor = UIColor(r: 22, g: 147, b: 162)
            }
        }
        
        return cell
    }

    @objc func handleROA()
    {
        myTable.reloadData()
    }

}
