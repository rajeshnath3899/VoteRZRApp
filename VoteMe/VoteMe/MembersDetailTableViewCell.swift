//
//  MembersDetailTableViewCell.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 2/20/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class MembersDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberVoterId: UILabel!
    @IBOutlet weak var memberRole: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
