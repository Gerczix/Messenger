//
//  MessageViewCell.swift
//  Messenger
//
//  Created by Gerard on 09/07/2020.
//  Copyright © 2020 Gerard. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    @IBOutlet var IDLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
