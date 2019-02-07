//
//  myFeedback.swift
//  Test Navigation
//
//  Created by Marius Lazar on 07/02/2019.
//  Copyright © 2019 Marius Lazar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class myFeedback: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellID = "cellMyProf"
    
    var jsonFeedback = [infoUsers]()
    let userID = Auth.auth().currentUser!.uid
    
    lazy var myTable: UITableView = {
        var tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.delegate = self
        tbl.dataSource = self
        tbl.rowHeight = 150
        tbl.register(myProfileCell.self, forCellReuseIdentifier: cellID)
        return tbl
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addSubview(myTable)
        navigationItem.title = "Feedback"
        myTable.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        myTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        myTable.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return jsonFeedback.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! myProfileCell
        
        cell.imageFeedback.image = nil
        let post = jsonFeedback[indexPath.row]
        cell.descrizione.text = post.descrizione
        cell.start.alpha = 1
        cell.titolo.alpha = 0
        cell.oreMinuti.alpha = 0
        if self.userID == "RtvEIHrdBXWfddMLletlSDbMqcc2"
        {
            cell.imageFeedback.image = UIImage(named: "PtXGYG1Qx7gheDkehkiZmJAaOuy1")
        }
        else
        {
            cell.imageFeedback.image = UIImage(named: "RtvEIHrdBXWfddMLletlSDbMqcc2")
        }

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        
    }


}
