//
//  FornisciRichiediController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 29/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit

class FornisciRichiediController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
   
    
    lazy var lblTitle: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.text = "Titolo annuncio"
        return lbl
    }()
    
    lazy var txtViewTitle: UITextView = {
        var txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.layer.borderWidth = 0.3
        txt.layer.borderColor = UIColor.lightGray.cgColor
        return txt
    }()
    
    lazy var lblDescription: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.text = "Descrizione annuncio"
        return lbl
    }()
    
    lazy var txtViewDescription: UITextView = {
        var txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.layer.borderWidth = 0.3
        txt.layer.borderColor = UIColor.lightGray.cgColor
        return txt
    }()
    
    lazy var lblCategoria: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.text = "Categoria"
        return lbl
    }()

    lazy var txtCategoriaScelta: UITextView = {
        var txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.textColor = UIColor.lightGray
        txt.backgroundColor = .white
        txt.layer.borderWidth = 0.3
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.text = "Scegli una categoria"
        txt.isEditable = false
        return txt
    }()
    
    lazy var lblLuogo: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.text = "Luogo"
        return lbl
    }()
    
    lazy var txtLuogo: UITextView = {
        var txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.layer.borderWidth = 0.3
        txt.layer.borderColor = UIColor.lightGray.cgColor
        return txt
    }()
    
    lazy var lblImage: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.text = "Aggiungi foto"
        return lbl
    }()
    
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
    
    lazy var scroll: UIScrollView = {
        var scroll = UIScrollView()
        scroll.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var picker = UIPickerView()
    var pickerMinutes = UIPickerView()

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
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        view.addSubview(scroll)
        scroll.addSubview(lblTitle)
        scroll.addSubview(txtViewTitle)
        scroll.addSubview(lblDescription)
        scroll.addSubview(txtViewDescription)
        scroll.addSubview(lblCategoria)
        scroll.addSubview(txtCategoriaScelta)
        scroll.addSubview(lblLuogo)
        scroll.addSubview(txtLuogo)
        

        picker.delegate = self
        picker.dataSource = self
        picker.tag = 1
        
        pickerMinutes.delegate = self
        pickerMinutes.dataSource = self
        pickerMinutes.tag = 2
        
        
        let gestureAdd = UITapGestureRecognizer(target: self, action: #selector(handleAddPhoto))
        addImage.addGestureRecognizer(gestureAdd)
        
        txtCategoriaScelta.inputView = picker
        
        
        configureConstraints()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismssKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    let categorie = ["prova1", "prova2", "prova3", "prova4", "prova5"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return categorie.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return categorie[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.txtCategoriaScelta.text = self.categorie[row]

        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
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

        lblTitle.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 48).isActive = true
        lblTitle.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 16).isActive = true
        
        txtViewTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 4).isActive = true
        txtViewTitle.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        txtViewTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        lblDescription.topAnchor.constraint(equalTo: txtViewTitle.bottomAnchor, constant: 16).isActive = true
        lblDescription.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 16).isActive = true
        
        txtViewDescription.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 4).isActive = true
        txtViewDescription.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        txtViewDescription.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        lblCategoria.topAnchor.constraint(equalTo: txtViewDescription.bottomAnchor, constant: 16).isActive = true
        lblCategoria.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 16).isActive = true
        
        txtCategoriaScelta.topAnchor.constraint(equalTo: lblCategoria.bottomAnchor, constant: 4).isActive = true
        txtCategoriaScelta.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        txtCategoriaScelta.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        lblLuogo.topAnchor.constraint(equalTo: txtCategoriaScelta.bottomAnchor, constant: 16).isActive = true
        lblLuogo.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 16).isActive = true
        
        txtLuogo.topAnchor.constraint(equalTo: lblLuogo.bottomAnchor, constant: 4).isActive = true
        txtLuogo.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        txtLuogo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
//        pickerCategoria.topAnchor.constraint(equalTo: lblCategoria.bottomAnchor, constant: 4).isActive = true
//        pickerCategoria.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
    }

    
}
