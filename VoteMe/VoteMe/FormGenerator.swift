//
//  FormGenerator.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation


enum Role: String {
    
    case father = "Father"
    case mother = "Mother"
    case son = "Son"
    case daughter = "Daughter"
    case other = "Other"
    
}


class FormGenerator {
    
    func generateUIData(memberList: MemberList) -> [String] {
        
        var list = [String]()
        
        if (memberList.father) {
            
            list.append(Role.father.rawValue)
            
        }
        
        if (memberList.mother) {
            
             list.append(Role.mother.rawValue)
            
        }
        
        createList(members: &list, count: memberList.sons, role: .son)
        createList(members: &list, count: memberList.daughters, role: .daughter)
        createList(members: &list, count: memberList.others, role: .other)

        
        
        return list
        
    }
    
    func createList(members: inout [String], count: Int, role: Role) {

        let stringValue = role.rawValue
        
        if count == 0 {
            
            return
        }
        
        for i in 1...count {
            
            
            members.append(stringValue + ":\(i)")
            
            
            
            
        }
        
    }
    
    
}
