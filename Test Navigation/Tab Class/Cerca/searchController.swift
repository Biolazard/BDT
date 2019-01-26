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
    var feedbackRilasciato: Bool?
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
}

import UIKit
import FirebaseAuth
import FirebaseDatabase

class searchController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")
    var jsonDownloaded: [download] = []
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addSubview(myTable)

        view.showBlurLoader()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(r: 22, g: 147, b: 162)
        navigationItem.title = "Cerca"
        configureConstraints()
        
        downloadArray()
    }

    func configureConstraints()
    {
        myTable.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        myTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        myTable.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    @objc func downloadArray()
    {
        dataBase.child("Post").observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any]
            {
                self.view.removeBluerLoader()
                var fetchArray: [download] = []
                for element in dictionary
                {
                    
                    let value = element.value as? [String: Any]
                    
                    let post = download(cambioOra: self.castToBool(value: value?["cambio ora"] as? String), categoria: value!["categoria"] as? String, descrizione: value?["descrizione"] as? String, feedbackRilasciato: self.castToBool(value: value?["feedback rilasciato"] as? String), luogo: value?["luogo"] as? String, minuti: value?["minuti"] as? Int, ore: value?["ore"] as? Int, postAssegnato: self.castToBool(value: value?["post assegnato"] as? String), terminaDaBoss: self.castToBool(value: value?["termina da boss"] as? String), richiestaofferta: value?["richiestaofferta"] as? String, terminaDaUtente: self.castToBool(value: value?["termina utente help"] as? String), titolo: value?["titolo"] as? String, idBoss: value?["utente boss"] as? String, idPost: value?["idPost"] as? Int, proposte: value?["proposte"] as? String)
                    fetchArray.append(post)
                }
                self.jsonDownloaded = fetchArray
                self.myTable.reloadData()
                
            }
            else
            {
                self.view.removeBluerLoader()
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
        return jsonDownloaded.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let post = jsonDownloaded[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let detailController = detailPostSearch()
        detailController.title = "Post"
        if post.postAssegnato == true
        {
            detailController.lblProposte.text = "Assegnato a"
        }
        if post.proposte != ""
        {
            detailController.btnInviaRichiesta.setTitle("Richiesta inviata", for: .normal)
            detailController.btnInviaRichiesta.isEnabled = false
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
        
        let post = jsonDownloaded[indexPath.row]
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
