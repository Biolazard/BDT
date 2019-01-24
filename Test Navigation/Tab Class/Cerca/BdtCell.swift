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
        
        lblLuogo.translatesAutoresizingMaskIntoConstraints = false
        lblLuogo.numberOfLines = 1
        lblLuogo.font = .italicSystemFont(ofSize: 16)
        
        contentView.addSubview(imageWork)
        contentView.addSubview(lblTitolo)
        contentView.addSubview(lblCosto)
        contentView.addSubview(lblLuogo)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints()
    {
        imageWork.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        imageWork.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageWork.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageWork.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        lblTitolo.leftAnchor.constraint(equalTo: imageWork.rightAnchor, constant: 10).isActive = true
        lblTitolo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        lblTitolo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        
        lblCosto.leftAnchor.constraint(equalTo: imageWork.rightAnchor, constant: 8).isActive = true
        lblCosto.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        lblCosto.topAnchor.constraint(equalTo: lblTitolo.bottomAnchor, constant: 8).isActive = true
        
        lblLuogo.leftAnchor.constraint(equalTo: imageWork.rightAnchor, constant: 8).isActive = true
        lblLuogo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        lblLuogo.topAnchor.constraint(equalTo: lblCosto.bottomAnchor, constant: 8).isActive = true
        
    }
}
