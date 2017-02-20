//
//  VMUtil.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 2/18/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation
import UIKit

class VMUtil {
    
    static var configuration: VMConfiguration {
        var returnValue: VMConfiguration
        do {
            let tempReturnValue = try PListManager.loadDataFromPlist(name: ConfigKeys.VoteMeKeysPlistName.rawValue, atPath: .sourceBundle)
            returnValue = VMConfiguration(plist: tempReturnValue)
        } catch {
            print("\(ErrorKeys.couldNotInitialize.rawValue) \(error)")
            returnValue = VMConfiguration(localBaseRequestURL: "",
                                          remoteBaseRequestURL: "",
                                          isLocal: true)
        }
        return returnValue
    }
    
    
   static func createAlert(with title:String, message: String, style: UIAlertControllerStyle, actionStyle: UIAlertActionStyle) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: title, style: actionStyle, handler: nil))
        
        return alert
        
    }
    
}
