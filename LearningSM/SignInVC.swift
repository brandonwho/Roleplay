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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}

