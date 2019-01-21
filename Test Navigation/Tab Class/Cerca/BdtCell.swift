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
    let lblWork = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageWork.translatesAutoresizingMaskIntoConstraints = false
        imageWork.contentMode = .scaleAspectFit
        
        lblWork.translatesAutoresizingMaskIntoConstraints = false
        lblWork.numberOfLines = 3
        
        contentView.addSubview(imageWork)
        contentView.addSubview(lblWork)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints()
    {
        imageWork.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        imageWork.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageWork.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageWork.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lblWork.leftAnchor.constraint(equalTo: imageWork.rightAnchor, constant: 8).isActive = true
        lblWork.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        lblWork.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        lblWork.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        lblWork.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
    }
}
