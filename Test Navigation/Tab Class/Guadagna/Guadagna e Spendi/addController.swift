//
//  addController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 17/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit

class addController: UIViewController {

    lazy var waveImage: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "wave")
        return img
    }()
    
    lazy var inserisciAnnuncio: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Inserisci il tuo \nannuncio!"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    lazy var btnFornisci: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Fornisci un Servizio", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handleFornisci), for: .touchUpInside)
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    lazy var btnRichiedi: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Richiedi un Servizio", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handleRichiedi), for: .touchUpInside)
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if navigationController?.navigationBar.isHidden == false
        {
            navigationController?.setNavigationBarHidden(true, animated: true)
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.compact)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.addSubview(waveImage)
        view.addSubview(inserisciAnnuncio)
        view.addSubview(btnFornisci)
        view.addSubview(btnRichiedi)
        
        setupConstraints()
    }
    
    func hidenNavigationBar()
    {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = true
    }
    @objc func handleFornisci()
    {
        let controller = FornisciRichiediController()
        controller.title = "Fornisci"
        controller.titoloNav = "fornisce"
        hidenNavigationBar()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc func handleRichiedi()
    {
        let controller = FornisciRichiediController()
        controller.title = "Richiedi"
        controller.titoloNav = "richiede"
        hidenNavigationBar()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupConstraints()
    {
        waveImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        waveImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        waveImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        inserisciAnnuncio.centerXAnchor.constraint(equalTo: waveImage.centerXAnchor).isActive = true
        inserisciAnnuncio.centerYAnchor.constraint(equalTo: waveImage.centerYAnchor).isActive = true
        
        btnFornisci.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32).isActive = true
        btnFornisci.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnFornisci.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        btnRichiedi.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 32).isActive = true
        btnRichiedi.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnRichiedi.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
    }

}
