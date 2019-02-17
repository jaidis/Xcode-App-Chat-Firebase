//
//  Chat.swift
//  Xcode-App-Chat-Firebase
//
//  Created by Manuel Muñoz on 17/2/19.
//  Copyright © 2019 Manuel Muñoz. All rights reserved.
//

import UIKit

class Chat {
    var userName: String?
    var text:String?
    var datePost:String?
    init(userName:String,text:String,datePost:String) {
        self.userName = userName
        self.text = text
        self.datePost = datePost
    }
}
