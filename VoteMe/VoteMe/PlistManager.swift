//
//  PlistConfig.swift
//  BrainView
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 12/08/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//



import Foundation

// MARK: - MKB Additions Start -

typealias PListDictionary = [String: AnyObject]

protocol PListKey : RawRepresentable {
}

protocol PListValue {}


extension	Bool: PListValue {}
extension	String: PListValue {}
extension	Int: PListValue {}
extension	Date: PListValue {}
extension	Data: PListValue {}
extension	Dictionary: PListValue {}
extension	Array: PListValue {}


extension Dictionary where Value: AnyObject {
	func value<V: PListValue, K: PListKey>(forKey key: K) -> V where K.RawValue == String {
		return self[key.rawValue as! Key] as! V
	}
}

// MARK: - MKB Additions End -

class PListManager: NSObject {
    
    //Make PlistManager a singleton
    static let SharedInstance: PListManager = {
        
        var manager = PListManager()
        
        return manager
        
    }()
    
    let documentsPath: URL = {
        
        let fileManager = FileManager.default
        
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentPathURL = urls[0]
        return documentPathURL
        
    }()
    
}

// MARK: - Methods related to loading from and writing to plist files

extension PListManager {
    
    enum PListError:Error {
        
        case fileNotWritten
        case fileDoesNotExist
        case fileNotRead
    }
    
    enum PListPath {
        
        case sourceBundle
        case documents
        
    }
    
    class func loadDataFromPlist(name plist: String,
                                 atPath plistFilePath: PListManager.PListPath) throws -> /*NSDictionary*/PListDictionary {
    
        var filePath = ""
        
        switch plistFilePath {
            
            case .documents:
            
                filePath = PListManager.SharedInstance.documentsPath.appendingPathComponent("\(plist).plist").path
            
            case .sourceBundle:
            
                if let path = Bundle.main.url(forResource: plist, withExtension: "plist")?.path {
					filePath = path
				} else {
					throw PListError.fileDoesNotExist
			}
		}
		
		let fileManager = FileManager.default
		
		if fileManager.fileExists(atPath:filePath) {
			guard let dict = NSDictionary(contentsOfFile: filePath) else {
				throw PListError.fileNotRead
			}
			return dict as! PListDictionary
		}
        
        throw PListError.fileDoesNotExist
        
    }
    
    
    class func writeDictionaryToPlist(filename name :String,dictionary:NSDictionary)  throws {

		let filePath =  PListManager.SharedInstance.documentsPath.appendingPathComponent("\(name).plist").path
		
		if dictionary.write(toFile: filePath, atomically: false) {
			print("Plist Saved !")
		} else {
			throw PListError.fileNotWritten
		}
	}
}
