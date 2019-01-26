//
//  BdtCell.swift
//  Test Navigation
//
//  Created by Marius Lazar on 29/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit

class FoaCell: UITableViewCell {
    
    let imageProposte = UIImageView()
    let lblTitolo = UILabel()
    let lblCosto = UILabel()
    let lblProposteOInCorso = UILabel()
    var nomeAssegnato: String?
    var postAssegnato: Bool?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageProposte.translatesAutoresizingMaskIntoConstraints = false
        imageProposte.contentMode = .scaleAspectFit
        
        lblTitolo.translatesAutoresizingMaskIntoConstraints = false
        lblTitolo.numberOfLines = 1
        lblTitolo.font = .boldSystemFont(ofSize: 16)
        
        lblCosto.translatesAutoresizingMaskIntoConstraints = false
        lblCosto.numberOfLines = 1
        
        lblProposteOInCorso.translatesAutoresizingMaskIntoConstraints = false
        lblProposteOInCorso.numberOfLines = 1
        lblProposteOInCorso.font = .boldSystemFont(ofSize: 16)
        
        contentView.addSubview(imageProposte)
        contentView.addSubview(lblTitolo)
        contentView.addSubview(lblCosto)
        contentView.addSubview(lblProposteOInCorso)

        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints()
    {
        
        
        lblTitolo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        lblTitolo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        
        lblCosto.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        lblCosto.topAnchor.constraint(equalTo: lblTitolo.bottomAnchor, constant: 8).isActive = true
        
        imageProposte.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        imageProposte.topAnchor.constraint(equalTo: lblCosto.bottomAnchor, constant: 8).isActive = true
        imageProposte.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageProposte.heightAnchor.constraint(equalToConstant: 40).isActive = true

        lblProposteOInCorso.leftAnchor.constraint(equalTo: imageProposte.rightAnchor, constant: 8).isActive = true
        lblProposteOInCorso.centerYAnchor.constraint(equalTo: imageProposte.centerYAnchor).isActive = true

    }
}
