//
//  VMModel.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 2/18/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation



struct Voter  {
    
    let leadVoterName: String
    let leadVoterRole: String
    let leadVoterId: String
    let address: String
    let wardName: String
    let wardNo: String
    let members:[Identity]?
    
    init(inDict: [String:Any]) {
        
        self.leadVoterId = inDict[VoterModelKey.leadVoterId.rawValue] as! String? ?? ""
        
        self.leadVoterName = inDict[VoterModelKey.leadName.rawValue] as! String? ?? ""
        
        self.leadVoterRole = inDict[VoterModelKey.leadRole.rawValue] as! String? ?? ""
        self.address = inDict[VoterModelKey.address.rawValue] as! String? ?? ""
        self.wardName = inDict[VoterModelKey.wardName.rawValue] as! String? ?? ""
        self.wardNo = inDict[VoterModelKey.wardNo.rawValue] as! String? ?? ""
        
        let memberList = inDict[VoterModelKey.members.rawValue] as! [[String:String]]
        
        var identities = [Identity]()
        
        for item  in memberList {
            
            let member = Identity(inDict: item)
            identities.append(member)
            
        }
        
        self.members = identities
                

    }
    
}

struct Identity {
    
    let voterId: String
    let name: String
    let memberRole: String
    
    init (inDict: [String : String]) {
        
        self.voterId = inDict[VoterModelKey.voterId.rawValue] ?? ""
        self.name = inDict[VoterModelKey.name.rawValue] ?? ""
        self.memberRole = inDict[VoterModelKey.memberRole.rawValue] ?? ""
        
    }


}

