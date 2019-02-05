//
//  BdtCell.swift
//  Test Navigation
//
//  Created by Marius Lazar on 29/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit
import Cosmos

class feedbackCell: UITableViewCell {
    
    var imageFeedback = UIImageView()
    var start = CosmosView()
    var descrizione = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        start.translatesAutoresizingMaskIntoConstraints = false
        start.settings.updateOnTouch = false
        start.settings.textColor = .white
        start.settings.totalStars = 5
        
        imageFeedback.translatesAutoresizingMaskIntoConstraints = false
        imageFeedback.contentMode = .scaleAspectFit
        
        descrizione.translatesAutoresizingMaskIntoConstraints = false
        descrizione.numberOfLines = 0
        
        
        contentView.addSubview(imageFeedback)
        contentView.addSubview(start)
        contentView.addSubview(descrizione)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints()
    {
        
        imageFeedback.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imageFeedback.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        imageFeedback.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageFeedback.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        start.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        start.leftAnchor.constraint(equalTo: imageFeedback.rightAnchor, constant: 16).isActive = true
        
        descrizione.topAnchor.constraint(equalTo: start.bottomAnchor, constant: 4).isActive = true
        descrizione.leftAnchor.constraint(equalTo: imageFeedback.rightAnchor, constant: 16).isActive = true
        descrizione.widthAnchor.constraint(equalToConstant: 250).isActive = true
        descrizione.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
    }
}
