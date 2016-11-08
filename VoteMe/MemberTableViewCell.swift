//
//  MemberTableViewCell.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtVoterId: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
