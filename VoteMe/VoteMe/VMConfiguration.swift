//
//  GoodFoodConfiguration.swift
//  GoodFood
//
//  Created by Pavithra G. Jayanna on 16/08/16.

//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

struct VMConfiguration {
	
	let localBaseRequestURL: String
	let remoteBaseRequestURL: String
	var isLocal: Bool
    
}


extension VMConfiguration {
	init(dictionary: [String: AnyObject]) {
		localBaseRequestURL = dictionary[ConfigKeys.appRouteLocal.rawValue] as! String
		remoteBaseRequestURL = dictionary[ConfigKeys.appRouteRemote.rawValue] as! String
		isLocal = dictionary[ConfigKeys.isLocalKey.rawValue] as! Bool
	}
}

extension VMConfiguration {
	private enum Keys: String, PListKey {
		case isLocal
		case appRouteLocal
		case appRouteRemote
	}
	
	init(plist: PListDictionary) {
		localBaseRequestURL = plist.value(forKey: Keys.appRouteLocal)
		remoteBaseRequestURL = plist.value(forKey: Keys.appRouteRemote)
		isLocal = plist.value(forKey: Keys.isLocal)
	}
	
}
