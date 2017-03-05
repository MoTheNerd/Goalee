//
//  LoginPage.swift
//  Goalee
//
//  Created by Mohammad Al-Ahdal on 2017-03-02.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import UIKit

class LoginPage:UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //darkwallpaper
        self.view.backgroundColor = UIColor(hex: 0x000000)
        
        //enableKayboardTapOut
        self.hideKeyboardWhenTappedAround()
        
        //set buttons to correct size and border colour
        for view in self.view.subviews {
            if view is UIButton {
                (view as! UIButton).layer.cornerRadius = (view as! UIButton).frame.height/2
                (view as! UIButton).layer.borderWidth = 0.5
                (view as! UIButton).layer.borderColor = UIColor(hex: 0xFFFFFF).cgColor
            }
            if view is UITextField{
                (view as! UITextField).textColor = UIColor(hex: 0xFFFFFF)
            }
        }
        //signup button styling
        signUpButton.layer.backgroundColor = UIColor(hex: 0x000000).cgColor
        signUpButton.tintColor = UIColor(hex: 0xFFFFFF)
        
        //login button styling
        loginButton.layer.backgroundColor = UIColor(hex: 0xFFFFFF).cgColor
        loginButton.tintColor = UIColor(hex: 0x0000000)
        
        //email and password field styling
        emailField.keyboardType = UIKeyboardType.emailAddress
        emailField.autocorrectionType = .no
        passwordField.isSecureTextEntry = true
        emailField.attributedPlaceholder = NSAttributedString(string: emailField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xFFFFFF, alpha: 0.7)])
        passwordField.attributedPlaceholder = NSAttributedString(string: passwordField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xFFFFFF, alpha: 0.7)])
        
    }
    @IBAction func signUpRequested(_ sender: Any) {
        
        if (passwordField.text != nil && emailField.text != nil) {
            if (passwordField.text != "" && emailField.text != ""){
                //check email for string,@,string,.,string at least and does not include . as end
                let emailTrue:Bool = (emailField.text?.isValidEmail())!
                //checkPassword for 6 values
                let passTrue:Bool = (passwordField.text?.characters.count)! >= 6
                if passTrue && emailTrue {
                    clientAuth?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {(user,error) in
                        if error != nil {
                            print((error?.localizedDescription)!)
                            self.emailField.text = ""
                            self.emailField.attributedPlaceholder = NSAttributedString(string: (error?.localizedDescription)!, attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                            self.passwordField.text = ""
                            self.passwordField.attributedPlaceholder = NSAttributedString(string: (error?.localizedDescription)!, attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                        }else if user != nil{
                            clientUser = user!
                        }else{
                            return
                        }
                    })
                }else{
                    if !passTrue{
                        self.passwordField.text = ""
                        self.passwordField.attributedPlaceholder = NSAttributedString(string: "Your password must have at least 6 characters", attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                    }
                    if !emailTrue{
                        self.emailField.text = ""
                        self.emailField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                    }
                }
            }else{
                if emailField.text == nil {
                    emailField.attributedPlaceholder = NSAttributedString(string: "Please enter an email", attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                }else if passwordField.text == nil {
                    passwordField.attributedPlaceholder = NSAttributedString(string: "Please enter a 6 character password", attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                }
            }
        }else{
            if emailField.text == nil {
                emailField.attributedPlaceholder = NSAttributedString(string: "Please enter an email", attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
            }else if passwordField.text == nil {
                passwordField.attributedPlaceholder = NSAttributedString(string: "Please enter a 6 character password", attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
            }
        }
    }
    @IBAction func loginRequested(_ sender: Any) {
        if (passwordField.text != nil && emailField.text != nil) {
            if (passwordField.text != "" && emailField.text != "") {
                clientAuth?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: {(user,error) in
                    if error != nil {
                        print((error?.localizedDescription)!)
                        self.emailField.text = ""
                        self.emailField.attributedPlaceholder = NSAttributedString(string: (error?.localizedDescription)!, attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                        self.passwordField.text = ""
                        self.passwordField.attributedPlaceholder = NSAttributedString(string: (error?.localizedDescription)!, attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xCC3333, alpha: 0.7)])
                    }else if user != nil {
                        clientUser = user!
                        self.performSegue(withIdentifier: "fromLoginToTabBar", sender: self)
                    }else {
                        return
                    }
                })
            }
        }
    }
    
}
