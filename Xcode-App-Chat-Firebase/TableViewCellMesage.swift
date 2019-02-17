//
//  TableViewCellMesage.swift
//  Xcode-App-Chat-Firebase
//
//  Created by Manuel Muñoz on 17/2/19.
//  Copyright © 2019 Manuel Muñoz. All rights reserved.
//

import UIKit

class TableViewCellMesage: UITableViewCell {

    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var tvText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setChat(chat:Chat){
        lbUsername.text = chat.userName
        tvText.text = chat.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
