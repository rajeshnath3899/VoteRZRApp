//
//  ServiceLayer.swift
//  SoodFood
//
//  Created by Pavithra G. Jayanna on 08/01/17.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

struct  VMServiceLayer {
    
    static let manager = VMServiceLayer()
    
    static func sharedManager() -> VMServiceLayer {
        return manager
    }
    
    
    
    
    
    func addVoterService(leadVoterId: String,
                         leadVoterName: String,
                         leadRole: String,
                         address: [String : String],
                         members: [[String : String]], onCompletion: @escaping (Bool?)-> Void) {
        
        VMServiceRequestManager.sharedManager().addVoter(leadVoterId: leadVoterId,leadVoterName: leadVoterName,leadRole: leadRole,addressDetail: address, members: members) { (response) in
            if let responseData = response {
                onCompletion(responseData)
            } else {
                onCompletion(nil)
            }
        }
        
    }
    
    
    
    
       func getVoterListService(by limit: Int ,with offset: Int , completion: @escaping ([Voter]?) -> Void) {
        VMServiceRequestManager.sharedManager().getVoterList(by: limit, with: offset) { (response) in
            
            var voters: [Voter] = []
            
            if let responseData: [[String:Any]] = response as! [[String : Any]]? {
                
                for item: [String:Any] in responseData {
                    
                    let voter: Voter = Voter(inDict: item)
                    
                    voters.append(voter)
                    
                }
                
                completion(voters)
                
                
            } else {
                completion(nil)
            }
            
            
        }
    }

    
    
    
    
    //MARK:- Register
    /*
     Handle user registration
     returns registration status
     */
  /*  func registerUser(userId : String,firstname: String,
                      lastname: String,
                      phoneNumber: String,
                      onCompletionRegistration: @escaping (String?) ->Void) {
        
        VMServiceRequestManager.sharedManager().registerUser(userId: userId,firstName: firstname,lastName: lastname,phoneNumber: phoneNumber) { (response) in
            if let responseData = response {
                onCompletionRegistration(responseData)
            } else {
                onCompletionRegistration(nil)
            }
        }
    }
    */
    
    
   
    /*
    /*
     Check for valid user
     returns response status as valid or invalid user
     */
    func validateUser(_ loggedUserId : String ,_ completionHandler: @escaping (String?) -> Void) {
        VMServiceRequestManager.sharedManager().validateUser(loggedUserId) { (response) in
            if let responseData = response {
                completionHandler(responseData)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    //PRAGMA MARK:- create a new Post
    
    func createPost(_ newpost: [String:Any], completionHandler: @escaping (Int?)->Void) {
        VMServiceRequestManager.sharedManager().createPost(newpost) { (postId) in
            if let postId = postId {
                completionHandler(postId)
            } else {
                completionHandler(nil)
            }
        }
    }
    
  
    
       
    func getPersonDetails(personId: String ,completionHandler: @escaping (Person?) -> Void) {
        SFServiceRequestManager.sharedManager().getMyInfo(personId, oncompletionHandler:  {(responseData) in
            if let responseData = responseData as? [String:Any] {
                let person =  Person(inDict: responseData as! [String : String])
                DispatchQueue.main.async {
                    completionHandler(person)
                }
            } else {
            
                completionHandler(nil)
            }
        })
    }
    
    func getMessages(postId: Int, completionHandler: @escaping ([Message]?) -> Void) {
        var myPostArray = [Message]()
        
        SFServiceRequestManager.sharedManager().getMessages(postId: postId) { (responsedata) in
            if let response = responsedata {
                for dict in response as! [[String :Any]] {
                    var messagedDate = Date()
                    var updatedDict = dict
                    if let messagedDateString = dict[MessagesModelKey.messageTime.rawValue] as? String {
                        messagedDate = SFUtility.getMessageDateFromString(dateString: messagedDateString)
                    }
                    updatedDict[MessagesModelKey.messageTime.rawValue] = messagedDate
                    let msg = Message(inDict: updatedDict)
                    myPostArray.append(msg)
                }
                completionHandler(myPostArray)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    //MARK:- Upload images for new post
    func uploadImages(_ postID: Int,
                      personID: String,
                      photoArray: [Data],
                      completionHandler: @escaping (String?)->Void) {
        SFServiceRequestManager.sharedManager().uploadNewPostImages(postID, personID: personID, uploadPhotoArray: photoArray, completionHandler: { (message) in
            if message == StringConstant.success.rawValue {
                completionHandler(message)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    //MARK:- Download images
    func downloadImages(_ postID: Int, completionHandler:@escaping ([[String:String]])->Void) {
        SFServiceRequestManager.sharedManager().downlaodImages(postID: postID, completion: { (response) in
            if let responseData = response {
                completionHandler(responseData)
            }
        })
    }
    
    //MARK:- Likes
    func likeFood(_postId:Int , onCompletionHandlr :@escaping ((String?)) ->Void ) {
        SFServiceRequestManager.sharedManager().likeFood(_postId: _postId , onCompletionHandlr: {(status) in
            if status  == StringConstant.success.rawValue {
                onCompletionHandlr(status)
            } else {
                onCompletionHandlr(nil)
                
            }
        })
    }
    
    //MARK:- Edit person profile pic
    func uploadProfileImage(_ person: Person, profilePic: Data, completionHandler: @escaping (String?) -> Void) {
        SFServiceRequestManager.sharedManager().editProfileImage(person, profilePicData: profilePic, completionHandler: {(message) in
            if message == StringConstant.success.rawValue {
                completionHandler(message)
            } else {
                completionHandler(nil)
            }
        })
    }
 */
    
}
