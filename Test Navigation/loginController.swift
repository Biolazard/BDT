//
//  ViewController.swift
//  Test Navigation
//
//  Created by Marius Lazar on 13/11/2018.
//  Copyright © 2018 Marius Lazar. All rights reserved.
//

import UIKit
import Firebase
class loginController: UIViewController {
    
    var btnLogin: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Registrati", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.contentHorizontalAlignment = .center
        btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return btn
    }()
    
    var changeLoginRegister: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sei già iscritto?", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.contentHorizontalAlignment = .center
        btn.addTarget(self, action: #selector(handleChange), for: .touchUpInside)
        return btn
    }()
    
    lazy var txtName: UITextField = {
        var txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.placeholder = "Nome"
        txt.backgroundColor = .white
//        txt.layer.cornerRadius = 5
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.borderWidth = 1
        txt.textAlignment = .left
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
        txt.addTarget(self, action: #selector(handleInputText), for: UIControl.Event.editingChanged)
        txt.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        return txt
    }()
    
    lazy var txtEmail: UITextField = {
        var txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.placeholder = "Email"
        txt.backgroundColor = .white
//        txt.layer.cornerRadius = 5
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.borderWidth = 1
        txt.textAlignment = .left
        txt.keyboardType = .emailAddress
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
        txt.addTarget(self, action: #selector(handleInputText), for: UIControl.Event.editingChanged)
        txt.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        return txt
    }()
    
    lazy var txtPassword: UITextField = {
        var txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 16)
        txt.placeholder = "Password"
        txt.backgroundColor = .white
//        txt.layer.cornerRadius = 5
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.borderWidth = 1
        txt.textAlignment = .left
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
        txt.isSecureTextEntry = true
        txt.addTarget(self, action: #selector(handleInputText), for: UIControl.Event.editingChanged)
        txt.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        return txt
    }()
    
    var allert: UIAlertController = {
        var allert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return allert
    }()
    
    let dataBase = Database.database().reference(fromURL: "https://banca-del-tempo-aa402.firebaseio.com")

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        view.addSubview(btnLogin)
        view.addSubview(changeLoginRegister)
        view.addSubview(txtName)
        view.addSubview(txtEmail)
        view.addSubview(txtPassword)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismssKeyboard))
        view.addGestureRecognizer(tap)
        
        handleInputText()
        configureConstraints()
        
       
    }

    
    @objc func handleInputText()
    {
        
        if btnLogin.titleLabel?.text == "Registrati"
        {
            if txtName.text?.trimmingCharacters(in: .whitespaces).isEmpty == true || txtEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty == true || txtPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty == true
            {
                btnLogin.isEnabled = false
                btnLogin.alpha = 0.5
            }
            else
            {
                btnLogin.isEnabled = true
                btnLogin.alpha = 1
                
            }
        }
        else
        {
            if txtEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty == true || txtPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty == true
            {
                btnLogin.isEnabled = false
                btnLogin.alpha = 0.5
            }
            else
            {
                btnLogin.isEnabled = true
                btnLogin.alpha = 1
                
            }
        }
        
    }
    
    @objc func handleChange()
    {
        handleDismssKeyboard()
        if btnLogin.titleLabel?.text == "Registrati"
        {
            changeLoginRegister.setTitle("Devi ancora registrarti?", for: .normal)
            btnLogin.setTitle("Login", for: .normal)
            btnLogin.titleLabel?.text = "Login"
            txtName.alpha = 0
        }
        else
        {
            changeLoginRegister.setTitle("Sei già iscritto?", for: .normal)
            btnLogin.setTitle("Registrati", for: .normal)
            btnLogin.titleLabel?.text = "Registrati"
            txtName.alpha = 1
        }
        handleInputText()
    }
    
    @objc func handleRegister()
    {
        handleDismssKeyboard()
        view.showBlurLoader()
        
        if let email = txtEmail.text, let password = txtPassword.text, let name = txtName.text
        {
            if btnLogin.titleLabel?.text == "Registrati"
            {
                Auth.auth().createUser(withEmail: email, password: password)
                { (response, error) in
                    if error != nil
                    {
                        self.allert.title = "Errore Registrazione"
                        self.allert.message = error?.localizedDescription
                        self.present(self.allert, animated: true, completion: nil)
                        self.view.removeBluerLoader()
                    }
                    else
                    {
                        if let userId = response?.user.uid
                        {
                            let utenti = self.dataBase.child("Utenti").child(userId)
                            let nuovoUtente = ["Nome": name, "Email": email]
                            utenti.updateChildValues(nuovoUtente, withCompletionBlock:
                            { (error, response) in
                                if error != nil
                                {
                                    self.allert.title = "Errore Registrazione"
                                    self.allert.message = error?.localizedDescription
                                    self.present(self.allert, animated: true, completion: nil)
                                    self.view.removeBluerLoader()
                                }
                                else
                                {
                                    debugPrint(response)
                                    self.view.removeBluerLoader()
                                    self.present(TabBarController(), animated: false, completion: nil)
                                }
                            })
                        }
                        
                    }
                }
            }
            else
            {
                debugPrint("LOGIN")
                Auth.auth().signIn(withEmail: email, password: password) { (response, error) in
                    if error != nil
                    {
                        self.allert.title = "Errore Login"
                        self.allert.message = error?.localizedDescription
                        self.present(self.allert, animated: true, completion: nil)
                        self.view.removeBluerLoader()
                    }
                    else
                    {
                        self.view.removeBluerLoader()
                        self.present(TabBarController(), animated: false, completion: nil)
                    }
                }
            }
            
        }
        
        

    }
    
    @objc func handleDismssKeyboard()
    {
        view.endEditing(true)
    }

    func configureConstraints()
    {
        txtName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtName.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 80).isActive = true
        txtName.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56).isActive = true
        txtName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        txtEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtEmail.topAnchor.constraint(equalTo: txtName.bottomAnchor, constant: 16).isActive = true
        txtEmail.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56).isActive = true
        txtEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        txtPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: 16).isActive = true
        txtPassword.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56).isActive = true
        txtPassword.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnLogin.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 16).isActive = true
        btnLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnLogin.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56).isActive = true
        
        changeLoginRegister.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 80).isActive = true
        changeLoginRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
}

