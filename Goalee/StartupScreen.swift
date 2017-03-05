//
//  StartupScreen.swift
//  Goalee
//
//  Created by Mohammad Al-Ahdal on 2017-03-02.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import UIKit
import KeychainSwift
import FirebaseAuth

let keychain:KeychainSwift = KeychainSwift()
var clientAuth:FIRAuth? = FIRAuth.auth()
var clientUser:FIRUser? = clientAuth?.currentUser

class StartupScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //keychain value for oauth is oauth
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clientAuth = FIRAuth.auth()
        if keychain.get("oauth") != nil {
            clientAuth!.signIn(withCustomToken: keychain.get("oauth")!, completion: {
                (user, error) in
                if error != nil {
                    print(error.debugDescription)
                    //anything else to do with error
                    //segue to login/signup page
                    self.performSegue(withIdentifier: "toLogin", sender: self)
                }else if user != nil {
                    clientUser = user
                    print("logged in as malahdal")
                }
            })
        }else{
            let dispTime = DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + UInt64(0.02 * Double(NSEC_PER_SEC)))
            DispatchQueue.main.asyncAfter(deadline: dispTime, execute: {
                () in
                self.performSegue(withIdentifier: "toLogin", sender: self)
            })
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
}
