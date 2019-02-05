//
//  ViewControllerGreen.swift
//  Test Navigation
//
//  Created by Marius Lazar on 13/11/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

struct download
{
    var cambioOra: Bool?
    var categoria: String?
    var descrizione: String?
    var feedbackRilasciatoBoss: Bool?
    var luogo: String?
    var minuti: Int?
    var ore: Int?
    var postAssegnato: Bool?
    var terminaDaBoss: Bool?
    var richiestaofferta: String?
    var terminaDaUtente: Bool?
    var titolo: String?
    var idBoss: String?
    var idPost: Int?
    var proposte: String?
    var feedbackRilasciatoHelper: Bool?
}

struct infoUsers
{
    var stars: Double?
    var descrizione: String?
}

import UIKit
import FirebaseAuth
import FirebaseDatabase

class guadagnaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellID = "cellIDBDT"
    
    lazy var myTable: UITableView = {
        var tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.delegate = self
        tbl.dataSource = self
        tbl.rowHeight = 100
        tbl.register(BdtCell.self, forCellReuseIdentifier: cellID)
        return tbl
    }()
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")
    var jsonMyPost: [download] = []
    var jsonOtherPost: [download] = []
    
    var myOrOther: Bool = true
    
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addSubview(myTable)
        view.showBlurLoader()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(r: 22, g: 147, b: 162)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "switch"), style: .done, target: self, action: #selector(handleSwitch))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddService))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = .white
        searchBar.placeholder = "Cerca tra i miei annunci"
        navigationItem.titleView = searchBar
        
        configureConstraints()
        downloadArray()
    }
    
    @objc func handleSwitch()
    {
        if self.myOrOther == true
        {
            self.myOrOther = false
            self.searchBar.placeholder = "Cerca tra altri annunci"
            self.myTable.reloadData()
        }
        else
        {
            self.myOrOther = true
            self.searchBar.placeholder = "Cerca tra i miei annunci"
            self.myTable.reloadData()
        }
    }
    
    @objc func handleAddService()
    {
        let controller = FornisciRichiediController()
        controller.title = "Fornisci"
        controller.titoloNav = "fornisce"
        self.present(controller, animated: true, completion: nil)
    }

    func configureConstraints()
    {
        myTable.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        myTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        myTable.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    func downloadArray()
    {
        dataBase.child("Post").observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any]
            {
                self.view.removeBluerLoader()
                var myPost: [download] = []
                var otherPost: [download] = []
                
                for element in dictionary
                {
                    let value = element.value as? [String: Any]
                    
                    let post = download(cambioOra: self.castToBool(value: value?["cambio ora"] as? String), categoria: value!["categoria"] as? String, descrizione: value?["descrizione"] as? String, feedbackRilasciatoBoss: self.castToBool(value: value?["feedback rilasciato boss"] as? String), luogo: value?["luogo"] as? String, minuti: value?["minuti"] as? Int, ore: value?["ore"] as? Int, postAssegnato: self.castToBool(value: value?["post assegnato"] as? String), terminaDaBoss: self.castToBool(value: value?["termina da boss"] as? String), richiestaofferta: value?["richiestaofferta"] as? String, terminaDaUtente: self.castToBool(value: value?["termina utente help"] as? String), titolo: value?["titolo"] as? String, idBoss: value?["utente boss"] as? String, idPost: value?["idPost"] as? Int, proposte: value?["proposte"] as? String, feedbackRilasciatoHelper: self.castToBool(value: value?["feedback rilasciato helper"] as? String))
                    if post.idBoss == self.userID && post.richiestaofferta == "fornisce"
                    {
                        myPost.append(post)
                    }
                    else if post.idBoss != self.userID && post.richiestaofferta == "richiede"
                    {
                        otherPost.append(post)
                    }
                }
                self.jsonMyPost = myPost
                self.jsonOtherPost = otherPost
                self.myTable.reloadData()
                
            }
            else
            {
                self.view.removeBluerLoader()
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
        switch self.myOrOther
        {
        case true:
            return jsonMyPost.count
        default:
            return jsonOtherPost.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let post = jsonMyPost[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let detailController = detailPostSearch()
        detailController.title = "Post"
        if post.postAssegnato == true
        {
            detailController.lblProposte.text = "Assegnato a"
            detailController.btnterminaServizio.alpha = 1
        }
        if post.proposte != ""
        {
            detailController.btnInviaRichiesta.setTitle("Richiesta inviata", for: .normal)
            detailController.btnInviaRichiesta.isEnabled = false
        }
        if post.postAssegnato == true
        {
            detailController.btnInviaRichiesta.setTitle("Termina servizio", for: .normal)
            detailController.btnInviaRichiesta.isEnabled = true
        }
        detailController.lblDescrizione.text = post.descrizione
        let ore = post.ore
        let minuti = post.minuti
        if minuti == 5 || minuti == 0
        {
            detailController.lblOreMinuti.text = "0\(ore ?? 00):0\(minuti ?? 00)h"
        }
        else
        {
            detailController.lblOreMinuti.text = "0\(ore ?? 00):\(minuti ?? 00)h"
        }
        detailController.lblTextLuogo.text = post.luogo
        detailController.uidUserBoss = post.idBoss
        detailController.proposte = post.proposte
        detailController.postInt = post.idPost
        self.navigationController?.pushViewController(detailController, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BdtCell
        var post: download
        switch self.myOrOther
        {
        case true:
            post = jsonMyPost[indexPath.row]
        default:
            post = jsonOtherPost[indexPath.row]
        }
        
        cell.imageWork.image = UIImage(named: post.idBoss!)
        cell.lblTitolo.text = post.titolo
        cell.lblLuogo.text = post.luogo
        cell.lblRichiedeOffre.text = post.richiestaofferta?.uppercased()
        let ore = post.ore
        let minuti = post.minuti
        if minuti == 5 || minuti == 0
        {
            cell.lblCosto.text = "0\(ore ?? 00):0\(minuti ?? 00)h"
        }
        else
        {
             cell.lblCosto.text = "0\(ore ?? 00):\(minuti ?? 00)h"
        }

        
        return cell
    }


}
