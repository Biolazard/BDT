//
//  FornisciRichiediController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 29/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit

class FornisciRichiediController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    lazy var addImage: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "placeholder")
        img.isUserInteractionEnabled = true
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.black.cgColor
        return img
    }()
    
    lazy var txtTitle: UITextField = {
        var txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.placeholder = "Titolo"
        txt.backgroundColor = .white
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.textAlignment = .left
        txt.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        return txt
    }()
    
    lazy var scroll: UIScrollView = {
        var scroll = UIScrollView()
        scroll.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 22, g: 147, b: 162)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Inserisci"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        view.addSubview(scroll)
        scroll.addSubview(addImage)
        scroll.addSubview(txtTitle)
        
        let gestureAdd = UITapGestureRecognizer(target: self, action: #selector(handleAddPhoto))
        addImage.addGestureRecognizer(gestureAdd)
        
        
        
        configureConstraints()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismssKeyboard))
        view.addGestureRecognizer(tap)

    }


    @objc func handleDismssKeyboard()
    {
        view.endEditing(true)
    }
    
    @objc func handleAddPhoto()
    {
        let alert = UIAlertController(title: "Aggiungi una Foto", message: "Seleziona uno dei seguenti metodi", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.handleAddImageCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Libreria", style: .default, handler: { (_) in
            self.handleAddImageLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func handleAddImageLibrary()
    {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func handleAddImageCamera()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            addImage.image = image
            addImage.layer.borderWidth = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    func configureConstraints()
    {
        scroll.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        addImage.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 24).isActive = true
        addImage.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        addImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addImage.heightAnchor.constraint(equalToConstant: 150).isActive = true

        txtTitle.topAnchor.constraint(equalTo: addImage.bottomAnchor, constant: 16).isActive = true
        txtTitle.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        txtTitle.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        txtTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        txtTitle.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -24).isActive = true
    }

    
}
