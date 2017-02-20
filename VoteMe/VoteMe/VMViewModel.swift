//
//  Data.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation


struct VoterInfo {
    
    let name: String = ""
    let voterId: String = ""
    
}

struct MemberList {
    
    var father: Bool = true
    var mother: Bool = true
    var sons: Int = 0
    var daughters: Int = 0
    var others: Int = 0
    var totalCount: Int = 0
    
    init(_ father: Bool,_ mother: Bool,_ sons: Int, _ daughters: Int, _ others: Int) {
        
        self.father = father
        self.sons = sons
        self.daughters = daughters
        self.others = others
        
        
        
        if (father && mother){
            
            self.totalCount = 2 + sons + daughters + others
            
        }
        else if (father){
            
            self.totalCount = 1 + sons + daughters + others
            
        } else if (mother) {
            
            self.totalCount = 1 + sons + daughters + others
        } else {
            
            self.totalCount = 0 + sons + daughters + others
        }

        
        
        
        
    }
    
}
