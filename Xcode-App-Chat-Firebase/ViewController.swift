//
//  ViewController.swift
//  Xcode-App-Chat-Firebase
//
//  Created by Manuel Muñoz on 15/2/19.
//  Copyright © 2019 Manuel Muñoz. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tf_ChatText: UITextField!
    @IBOutlet weak var tvChatList: UITableView!
    @IBOutlet weak var nvBarraSuperior: UINavigationBar!
    @IBAction func nvBack(_ sender: UIBarButtonItem) {
//        do {
//            try Auth.auth().signOut()
//        } catch let error {
//            print("Error trying to sign out of Firebase: \(error.localizedDescription)")
//        }
        self.dismiss(animated: true)
    }
    @IBAction func nvDrop(_ sender: UIBarButtonItem) {
        self.ref.removeValue()
    }
    
    var userName: String?
    var ref = DatabaseReference.init()
    var listOfChatInfo = [Chat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        self.ref = Database.database().reference()
        tvChatList.delegate = self
        tvChatList.dataSource = self
        loginAnonymous()
    }
    
    func assignbackground(){
        let background = UIImage(named: "BackgroundChat")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        tvChatList.backgroundColor = UIColor.clear
        nvBarraSuperior.backgroundColor = UIColor.clear
    }
    
    func loadChatMessages(){
        self.ref.child("chat").queryOrdered(byChild: "postDate").observe(.value , with: { (DataSnapshot) in
            self.listOfChatInfo.removeAll()
            if let snapshot = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let postData = snap.value as? [String:AnyObject]{
                        let userName = postData["user"] as? String
                        let text = postData["text"] as? String
                        let postDate = postData["postDate"] as? CLong
                        self.listOfChatInfo.append(Chat(userName: userName!, text: text!, datePost: "\(String(describing: postDate))"))
                    }
                }
                self.tvChatList.reloadData()
                let indexPath = IndexPath(row: self.listOfChatInfo.count-1, section:0)
                if self.listOfChatInfo.count > 0 {
                    self.tvChatList.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        })
    }
    
    func loginAnonymous(){
        Auth.auth().signInAnonymously(){
            (user,error) in
            if let error = error{
                print("Cannot login: \(error)")
            }else{
                print("user UID \(String(describing: user?.user.uid))")
                self.loadChatMessages()
            }
        }
    }
    

    @IBAction func bt_Username(_ sender: Any) {
        let message = [
            "user" : userName!,
            "text" : tf_ChatText.text!,
            "postData": ServerValue.timestamp() ] as [String:Any]
        self.ref.child("chat").childByAutoId().setValue(message)
        tf_ChatText.text = nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfChatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellChat:TableViewCellMesage = tableView.dequeueReusableCell(withIdentifier: "cellChat", for: indexPath) as! TableViewCellMesage
        cellChat.setChat(chat: listOfChatInfo[indexPath.row])
        cellChat.backgroundColor = UIColor.clear
        if self.userName == cellChat.lbUsername.text{
            cellChat.tvText.backgroundColor = UIColor.lightGray
            cellChat.tvText.textColor = UIColor.white
        }
        else{
            cellChat.tvText.backgroundColor = UIColor.darkGray
            cellChat.tvText.textColor = UIColor.white
        }
        return cellChat
    }
}

