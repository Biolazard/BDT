//
//  FornisciRichiediController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 29/12/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

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
    
    lazy var lblDurata: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.text = "Durata"
        return lbl
    }()
    
    lazy var txtDurata: UITextView = {
        var txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.layer.borderWidth = 0.3
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.isEditable = false
        return txt
    }()
    
    lazy var btnSend: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Invia", for: .normal)
        btn.backgroundColor = UIColor(r: 22, g: 147, b: 162)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .boldSystemFont(ofSize: 28)
        btn.contentHorizontalAlignment = .center
        btn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return btn
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
        scroll.addSubview(lblImage)
        scroll.addSubview(addImage)
        scroll.addSubview(lblDurata)
        scroll.addSubview(txtDurata)
        scroll.addSubview(btnSend)
        
        picker.delegate = self
        picker.dataSource = self
        picker.tag = 1
        
        pickerMinutes.delegate = self
        pickerMinutes.dataSource = self
        pickerMinutes.tag = 2
        
        let gestureAdd = UITapGestureRecognizer(target: self, action: #selector(handleAddPhoto))
        addImage.addGestureRecognizer(gestureAdd)
        
        txtCategoriaScelta.inputView = picker
        txtDurata.inputView = pickerMinutes
        
        configureConstraints()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismssKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    let categorie = ["prova1", "prova2", "prova3", "prova4", "prova5"]
    let ore = [00, 01, 02, 03, 04]
    let minuti = [00, 05, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        switch pickerView.tag
        {
        case 1:
            return 1
        default:
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerView.tag
        {
        case 1:
            return categorie.count
        default:
            switch component
            {
            case 0:
                return ore.count
                
            default:
                return minuti.count
            }
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView.tag
        {
        case 1:
            return categorie[row]
        default:
            switch component
            {
            case 0:
                return "\(ore[row]) h"
                
            default:
                return "\(minuti[row]) m"
            }
        }
        
    }
    
    var oreText = 0
    var minutiText = 0
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag
        {
        case 1:
            self.txtCategoriaScelta.text = self.categorie[row]
        default:
            switch component
            {
            case 0:
                oreText = ore[row]
                if minutiText == 5 || minutiText == 0
                {
                    self.txtDurata.text = "0\(oreText):0\(minutiText)"
                }
                else
                {
                    self.txtDurata.text = "0\(oreText):\(minutiText)"
                }
                
            default:
                minutiText = minuti[row]
                if minutiText == 5 || minutiText == 0
                {
                    self.txtDurata.text = "0\(oreText):0\(minutiText)"
                }
                else
                {
                    self.txtDurata.text = "0\(oreText):\(minutiText)"
                }
                
            }
        }
        
    }


    
    @objc func handleDismssKeyboard()
    {
        view.endEditing(true)
    }
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")
    var titoloNav: String?
    @objc func handleSend()
    {
        lblTitle.textColor = .black
        lblDescription.textColor = .black
        lblCategoria.textColor = .black
        lblLuogo.textColor = .black
        lblDurata.textColor = .black
        
        var errors = false
        
        if txtViewTitle.text.isEmpty == true
        {
            lblTitle.textColor = .red
            errors = true
        }
        
        if txtViewDescription.text.isEmpty == true
        {
            lblDescription.textColor = .red
            errors = true
        }
        
        if txtCategoriaScelta.text == "Scegli una categoria"
        {
            lblCategoria.textColor = .red
            errors = true
        }
        
        if txtLuogo.text.isEmpty == true
        {
            lblLuogo.textColor = .red
            errors = true
        }
        
        if txtDurata.text.isEmpty == true
        {
            lblDurata.textColor = .red
            errors = true
        }
        
        if errors == false
        {
            var post = 0
            if let postCreated = UserDefaults.standard.value(forKey: "numeroPost")
            {

                post = postCreated as! Int
            }
            else
            {
                UserDefaults.standard.set(0, forKey: "numeroPost")
                post = 0

            }
            let postToAdd = self.dataBase.child("Post").child("\(post)")
            let userID = Auth.auth().currentUser!.uid
            let newPost = ["utente boss": userID, "cambio ora": false, "proposte": "", "termina da boss": false, "titolo": txtViewTitle.text, "descrizione": txtViewDescription.text, "ore": oreText, "minuti": minutiText, "luogo": txtLuogo.text, "categoria": txtCategoriaScelta.text, "richiestaofferta": self.titoloNav!, "post assegnato": false, "feedback rilasciato": false, "termina utente help": false] as [String : Any]

            postToAdd.updateChildValues(newPost as [AnyHashable : Any], withCompletionBlock:
                { (error, response) in
                    if error != nil
                    {
                        debugPrint("errore")
                    }
                    else
                    {
                        debugPrint(response)
                        if let postCreated = UserDefaults.standard.value(forKey: "numeroPost")
                        {
                            
                            UserDefaults.standard.set(postCreated as! Int + 1, forKey: "numeroPost")
                        }
                         self.navigationController?.popViewController(animated: true)

                    }
            })
           
        }
        
        
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
        
        lblImage.topAnchor.constraint(equalTo: txtLuogo.bottomAnchor, constant: 48).isActive = true
        lblImage.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 16).isActive = true
        
        addImage.centerYAnchor.constraint(equalTo: lblImage.centerYAnchor).isActive = true
        addImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addImage.leftAnchor.constraint(equalTo: lblImage.rightAnchor, constant: 32).isActive = true
        
        lblDurata.topAnchor.constraint(equalTo: addImage.bottomAnchor, constant: 24).isActive = true
        lblDurata.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 16).isActive = true
        
        txtDurata.widthAnchor.constraint(equalToConstant: 60).isActive = true
        txtDurata.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txtDurata.centerYAnchor.constraint(equalTo: lblDurata.centerYAnchor).isActive = true
        txtDurata.leftAnchor.constraint(equalTo: lblDurata.rightAnchor, constant: 32).isActive = true
        txtDurata.centerXAnchor.constraint(equalTo: addImage.centerXAnchor).isActive = true
        
        btnSend.topAnchor.constraint(equalTo: txtDurata.bottomAnchor, constant: 48).isActive = true
        btnSend.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        btnSend.widthAnchor.constraint(equalTo: scroll.widthAnchor, constant: -56).isActive = true
        
    }

    
}
