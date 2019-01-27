//
//  BdtCell.swift
//  Test Navigation
//
//  Created by Marius Lazar on 29/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit
import Cosmos

class myProfileCell: UITableViewCell {
    
    var imageFeedback = UIImageView()
    var start = CosmosView()
    var descrizione = UILabel()
    var titolo = UILabel()
    var oreMinuti = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titolo.translatesAutoresizingMaskIntoConstraints = false
        titolo.font = .boldSystemFont(ofSize: 16)
        titolo.adjustsFontSizeToFitWidth = true
        
        start.translatesAutoresizingMaskIntoConstraints = false
        start.settings.updateOnTouch = false
        start.settings.textColor = .white
        start.settings.totalStars = 5
        
        imageFeedback.translatesAutoresizingMaskIntoConstraints = false
        imageFeedback.contentMode = .scaleAspectFit
        
        oreMinuti.translatesAutoresizingMaskIntoConstraints = false
    
        
        descrizione.translatesAutoresizingMaskIntoConstraints = false
        descrizione.numberOfLines = 0
        descrizione.lineBreakMode = .byCharWrapping
        
        contentView.addSubview(titolo)
        contentView.addSubview(imageFeedback)
        contentView.addSubview(start)
        contentView.addSubview(descrizione)
        contentView.addSubview(oreMinuti)
        
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
        
        oreMinuti.topAnchor.constraint(equalTo: imageFeedback.bottomAnchor, constant: 8).isActive = true
        oreMinuti.widthAnchor.constraint(equalToConstant: 80).isActive = true
        oreMinuti.centerXAnchor.constraint(equalTo: imageFeedback.centerXAnchor, constant: 8).isActive = true
        
        start.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        start.leftAnchor.constraint(equalTo: imageFeedback.rightAnchor, constant: 16).isActive = true
        
        titolo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titolo.leftAnchor.constraint(equalTo: imageFeedback.rightAnchor, constant: 16).isActive = true
        titolo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        descrizione.topAnchor.constraint(equalTo: start.bottomAnchor, constant: 8).isActive = true
        descrizione.leftAnchor.constraint(equalTo: imageFeedback.rightAnchor, constant: 16).isActive = true
        descrizione.widthAnchor.constraint(equalToConstant: 250).isActive = true
        descrizione.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
}
