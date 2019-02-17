//
//  ViewControllerLogin.swift
//  Xcode-App-Chat-Firebase
//
//  Created by Manuel Muñoz on 17/2/19.
//  Copyright © 2019 Manuel Muñoz. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {

    @IBOutlet weak var tf_Username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btLogin(_ sender: Any) {
        performSegue(withIdentifier: "chatView", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatView"{
            if let viewChat = segue.destination as? ViewController{
                viewChat.userName = tf_Username.text!
            }
        }
    }

}
