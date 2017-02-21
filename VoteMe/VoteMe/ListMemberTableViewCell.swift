//
//  ListMemberTableViewCell.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 2/20/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class ListMemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelVoterId: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelWardNo: UILabel!
    @IBOutlet weak var labelWardName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
