//
//  SignInVC.swift
//  LearningSM
//
//  Created by Brandon Rogers on 1/16/17.
//  Copyright © 2017 Brandon Rogers. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: LogInFields!
    @IBOutlet weak var passwordField: LogInFields!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewDidAppear(_ animated: Bool) {
/
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Brandon: Unable to authenicate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Brandon: User cancelled Facebook Authentication")
            } else {
                print("Brandon: Successfully Authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Brandon: Unable to Authenticate with Firebase - \(error)")
            } else {
                print("Brandon: Successfully Authenticated with Firebase")

            }
        })
    }

    @IBAction func logInTapped(_ sender: Any) {
        
        // add pop up saying to enter text
        if let email = emailField.text, let password = passwordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                print("Brandon: Email User Authenticated with Firebase")
                

                    
                } else {
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
                        (user, error) in
                        if error != nil {
                            print("Brandon: Unable to Authenticate with Firebase using Email")
                        } else {
                            print("Brandon: Successfully Authenticated with Firebase Email")
                            

                    }
                    
                })
            }
            
        })
    }
}

}

