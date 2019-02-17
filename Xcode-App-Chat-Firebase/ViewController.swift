//
//  ViewController.swift
//  Xcode-App-Chat-Firebase
//
//  Created by Manuel Muñoz on 15/2/19.
//  Copyright © 2019 Manuel Muñoz. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loginAnonymous()
    }
    
    func loginAnonymous(){
        Auth.auth().signInAnonymously(){
            (user,error) in
            if let error = error{
                print("Cannot login: \(error)")
            }else{
                print("user UID \(String(describing: user?.user.uid))")
            }
        }
    }


}

