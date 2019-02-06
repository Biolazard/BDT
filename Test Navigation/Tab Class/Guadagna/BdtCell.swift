//
//  BdtCell.swift
//  Test Navigation
//
//  Created by Marius Lazar on 29/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit

class BdtCell: UITableViewCell {

    let imageWork = UIImageView()
    let lblTitolo = UILabel()
    let lblCosto = UILabel()
    let lblLuogo = UILabel()
    let lblRichiedeOffre = UILabel()
    let lblAction = UILabel()
    
    var valoreUUID: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageWork.translatesAutoresizingMaskIntoConstraints = false
        imageWork.contentMode = .scaleAspectFit
        
        lblTitolo.translatesAutoresizingMaskIntoConstraints = false
        lblTitolo.numberOfLines = 1
        lblTitolo.font = .boldSystemFont(ofSize: 16)
        
        lblCosto.translatesAutoresizingMaskIntoConstraints = false
        lblCosto.numberOfLines = 1
        lblCosto.adjustsFontSizeToFitWidth = true
        
        lblLuogo.translatesAutoresizingMaskIntoConstraints = false
        lblLuogo.numberOfLines = 1
        lblLuogo.font = .italicSystemFont(ofSize: 16)
        lblLuogo.adjustsFontSizeToFitWidth = true
        
        lblRichiedeOffre.translatesAutoresizingMaskIntoConstraints = false
        lblRichiedeOffre.numberOfLines = 1
        lblRichiedeOffre.font = .boldSystemFont(ofSize: 16)
        lblRichiedeOffre.textColor = UIColor(r: 22, g: 147, b: 162)
        lblRichiedeOffre.adjustsFontSizeToFitWidth = true
        lblRichiedeOffre.alpha = 0
        
        lblAction.translatesAutoresizingMaskIntoConstraints = false
        lblAction.numberOfLines = 1
        lblAction.adjustsFontSizeToFitWidth = true

        contentView.addSubview(imageWork)
        contentView.addSubview(lblTitolo)
        contentView.addSubview(lblCosto)
        contentView.addSubview(lblLuogo)
        contentView.addSubview(lblRichiedeOffre)
        contentView.addSubview(lblAction)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints()
    {
        imageWork.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        imageWork.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageWork.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageWork.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        lblTitolo.leftAnchor.constraint(equalTo: imageWork.rightAnchor, constant: 10).isActive = true
        lblTitolo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        lblTitolo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        lblTitolo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        lblCosto.leftAnchor.constraint(equalTo: imageWork.rightAnchor, constant: 8).isActive = true
        lblCosto.topAnchor.constraint(equalTo: lblTitolo.bottomAnchor, constant: 2).isActive = true
        lblCosto.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        lblLuogo.leftAnchor.constraint(equalTo: imageWork.rightAnchor, constant: 8).isActive = true
        lblLuogo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        lblLuogo.topAnchor.constraint(equalTo: lblCosto.bottomAnchor, constant: 8).isActive = true
        lblLuogo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lblRichiedeOffre.leftAnchor.constraint(equalTo: lblCosto.rightAnchor, constant: 64).isActive = true
        lblRichiedeOffre.centerYAnchor.constraint(equalTo: lblCosto.centerYAnchor, constant: -24).isActive = true
        lblRichiedeOffre.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lblRichiedeOffre.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        lblAction.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        lblAction.leftAnchor.constraint(equalTo: lblCosto.rightAnchor, constant: -40).isActive = true
        lblAction.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lblAction.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        
    }
}
