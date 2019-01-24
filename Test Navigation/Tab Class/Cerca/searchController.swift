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
}

import UIKit
import FirebaseAuth
import FirebaseDatabase

class searchController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var btnLogin: UIButton = {
        var btn = UIButton(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Go on", for: .normal)
        return btn
    }()
    
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addSubview(myTable)
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
    
    func downloadArray()
    {
        dataBase.child("Post").observe(.value) { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : Any]
            {
                
                var fetchArray: [download] = []
                for element in dictionary
                {
                    let value = element.value as? [String: Any]
                    let post = download(cambioOra: value?["cambio ora"] as? Bool, categoria: value!["categoria"] as? String, descrizione: value?["descrizione"] as? String, feedbackRilasciato: value?["cambio ora"] as? Bool, luogo: value?["luogo"] as? String, minuti: value?["minuti"] as? Int, ore: value?["ore"] as? Int, postAssegnato: value?["posto assegnato"] as? Bool, terminaDaBoss: value?["termina da boss"] as? Bool, richiestaofferta: value?["richiestaofferta"] as? String, terminaDaUtente: value?["termina utente help"] as? Bool, titolo: value?["titolo"] as? String, idBoss: value?["utente boss"] as? String)
                    fetchArray.append(post)
                }
                self.jsonDownloaded = fetchArray
                self.myTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return jsonDownloaded.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BdtCell
        
        let post = jsonDownloaded[indexPath.row]
        cell.imageWork.image = UIImage(named: "weWantYou")
        cell.lblTitolo.text = post.titolo
        cell.lblLuogo.text = post.luogo
        let ore = post.ore
        let minuti = post.minuti
        if minuti == 5 || minuti == 0
        {
            cell.lblCosto.text = "0\(ore ?? 00):0\(minuti ?? 00)"
        }
        else
        {
             cell.lblCosto.text = "0\(ore ?? 00):\(minuti ?? 00)"
        }
        
        return cell
    }


}
