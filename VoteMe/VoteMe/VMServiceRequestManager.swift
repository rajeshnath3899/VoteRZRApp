//
//  ServiceRequestManager.swift
//  GoodFood
//
//  Created by pavithra G. Jayanna on 22/07/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class VMServiceRequestManager : NSObject, URLSessionDelegate {
    
    static let requestManager = VMServiceRequestManager()
    
    //PRAGMA MARK:- Singleton
    
    class func sharedManager() -> VMServiceRequestManager {
        return requestManager
    }
    
    // MKB: Not needed anymore.
    //    private  override init(){
    //    }
    
    func composeWithBaseURL(_ baseURL: String, andEndPoint endPoint: String) -> String {
        var newURL = ""
        newURL = baseURL + "/" + endPoint
        return newURL
    }
    
    func composeURLWithEndPoint(_ endPoint: String) -> String {
        return composeWithBaseURL(getSpotFoodBaseRequestURL(), andEndPoint: endPoint)
    }
    
    func initializeRequestHeader(_ request: inout URLRequest) {
        request.httpMethod = HttpMethod.post.rawValue
        request.addValue(HTTPHeaderContentTypeValues.json.rawValue,
                         forHTTPHeaderField: HTTPHeaderFields.contentType.rawValue)
        request.addValue(HTTPHeaderContentTypeValues.json.rawValue,
                         forHTTPHeaderField: HTTPHeaderFields.accept.rawValue)
    }
    
    func runPOSTWithBody<T>(_ receivedPostBody: Dictionary<String, Any>?,
                         endPoint: String,
                         responseDataKey: String,
                         completionHandler:@escaping (T?)->Void) throws {
        
        let requestURL = composeURLWithEndPoint(endPoint)
        var request = URLRequest(url: URL(string:requestURL)!)
        initializeRequestHeader(&request)
        
        do {
            if let postBody = receivedPostBody {
                let jsonData =  try JSONSerialization.data(withJSONObject: postBody, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpBody = jsonData
                print (postBody)
                print ("json data \(jsonData)")
            }
            
            let task = URLSession.shared
                .dataTask(with: request as URLRequest) {
                    (data, response, error) -> Void in
                    
                    if let responseData = data  {
                        do {
                            
                            let res = response as! HTTPURLResponse
                            print(res.statusCode)
                        
                            
                            let responseData =  try JSONSerialization.jsonObject(with:responseData,
                                                                                 options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                            
                            
                            if let status = responseData[responseDataKey] as? T {
                                completionHandler(status)
                            } else if let errorInfo = responseData[ErrorKeys.errorMessage.rawValue] as? String {
                                print(errorInfo) // Should we eat this error from server or throw this out?
                                //throw ServerError.error
                                //RCV: We could throw the error and once we catch the error can we write the error to logs ? or can we write the error to logs here itself ?
                                
                            } else {
                                completionHandler(nil) // empty type
                                
                            }
                        } catch let error_Level1 {
                            print(error_Level1)
                        }
                    } else {
                        completionHandler(nil)
                    }
            }
            task.resume()
        } catch let error_Level2 {
            print(error_Level2)
            throw ServerError.invalidJSON
        }
        
    }
    
    
    func addVoter(leadVoterId: String,
                         leadVoterName: String,
                         leadRole: String,
                         addressDetail: [String : String],
                         members: [[String : Any]],
                         completionHandler: @escaping (Bool?) -> Void) {
        
        let postBody = [VoterModelKey.voters.rawValue :
            [VoterModelKey.leadVoterId.rawValue:leadVoterId,
             VoterModelKey.leadName.rawValue:leadVoterName,
             VoterModelKey.leadRole.rawValue:leadRole,
             VoterModelKey.address.rawValue: addressDetail[VoterModelKey.address.rawValue
                ]!,
             VoterModelKey.wardNo.rawValue: addressDetail[VoterModelKey.wardNo.rawValue]!,
             VoterModelKey.wardName.rawValue: addressDetail[VoterModelKey.wardName.rawValue]!,
             VoterModelKey.members.rawValue: members] as [String : Any]]        
        do {
            try runPOSTWithBody(postBody, endPoint: UrlEndPoints.AddVoter.rawValue, responseDataKey: VoterModelKey.status.rawValue, completionHandler: completionHandler)
        } catch {
            print("\(ExceptionMessage.userIsNotRegister.rawValue) \(error)")
            
        }
        
        
        
    }
    


    
    /*
    //PRAGMA MARK:- Register
    func registerUser(userId :String ,
                      firstName:String,
                      lastName:String,
                      phoneNumber:String,
                      onCompletionHandlr :@escaping (String?) ->Void ) {
        
        let postBody = [PersonModelKey.id.rawValue:userId
            ,PersonModelKey.firstName.rawValue:firstName ,PersonModelKey.lastName.rawValue:lastName , PersonModelKey.phoneNumber.rawValue:phoneNumber]
        
        do {
            try runPOSTWithBody(postBody, endPoint: UrlEndPoints.registerUser.rawValue, responseDataKey: PostModelKey.status.rawValue, completionHandler: onCompletionHandlr)
        } catch {
            print("\(ExceptionMessage.userIsNotRegister.rawValue) \(error)")

        }
    }
    
    func validateUser(_ userId:String,completionHandler:@escaping ((String)?) -> Void) {
        let postBody = [PersonModelKey.id.rawValue :userId]
        print("\(UrlEndPoints.validateUser.rawValue) \(StringConstant.requestBody.rawValue)\(postBody)")

        do {
            try self.runPOSTWithBody(postBody,
                                     endPoint:  UrlEndPoints.validateUser.rawValue,
                                     responseDataKey: PostModelKey.status.rawValue,
                                     completionHandler: completionHandler)
        } catch {
            print("\(ExceptionMessage.userIsNotValidate.rawValue) \(error)")
        }
        
    }
    
    
    
    func editPost(_ editedPost: Post, completionHandler:@escaping (String?)->Void) {
        
        var editPostBody: [String : Any] = [:]

            editPostBody = [PostModelKey.id.rawValue:editedPost.id,
                              PostModelKey.eventName.rawValue:editedPost.eventName,
                              PostModelKey.description.rawValue:editedPost.description,
                              PostModelKey.locationLatitude.rawValue:editedPost.location.latitude, PostModelKey.locationLongitude.rawValue:editedPost.location.longitude, PostModelKey.postedBy.rawValue:editedPost.postedBypersonID,
                              PostModelKey.availableFromTime.rawValue:"\(editedPost.availableFromTime)",
                              PostModelKey.buildingName.rawValue:editedPost.buildingName, PostModelKey.floorNo.rawValue:editedPost.floorNo] as [String : Any]

        do {
            try self.runPOSTWithBody(editPostBody,
                                     endPoint: UrlEndPoints.editPost.rawValue,
                                     responseDataKey: ResponseDataKey.status.rawValue,
                                     completionHandler: completionHandler)
        } catch {
            print("\(ExceptionMessage.couldNotEditPost.rawValue) \(error)")
        }
    }
    
    func getAllPost(_ loggedUserId: String , onCompletionHandlr: @escaping (AnyObject?) ->Void ) {
        do {
            try   self.runPOSTWithBody(nil,
                                       endPoint:  UrlEndPoints.getAllPost.rawValue,
                                       responseDataKey: ResponseDataKey.allPosts.rawValue ,
                                       completionHandler: onCompletionHandlr)
        } catch {
            print("\(ExceptionMessage.couldNotLoadAllPosts.rawValue) \(error)")
        }
    }
    
    func getMyPosts(_ loggedUserId: String,oncompletionHandler: @escaping (AnyObject?) ->Void ) {
        let postBody =
            [PostModelKey.postedBy.rawValue :loggedUserId]

        do {
            try self.runPOSTWithBody(postBody,
                                     endPoint:  UrlEndPoints.getAllPost.rawValue,
                                     responseDataKey:ResponseDataKey.myPosts.rawValue,
                                     completionHandler: oncompletionHandler)
        } catch {
            print("\(ExceptionMessage.couldNotLoadMyPosts.rawValue) \(error)")
        }
        
    }
    
    func getMyInfo(_ loggedUserId: String,oncompletionHandler: @escaping (AnyObject?) ->Void ) {
        
        let postBody =
            [PersonModelKey.id.rawValue :loggedUserId]
        
        do {
            try self.runPOSTWithBody(postBody,
                                     endPoint: UrlEndPoints.getUserDetails.rawValue,
                                     responseDataKey:ResponseDataKey.details.rawValue,
                                     completionHandler: oncompletionHandler)
        } catch {
            print("\(ExceptionMessage.couldNotLoadMyInfo.rawValue) \(error)")
        }
    }
    
    //MARK:- Messages
    
    func getMessages(postId: Int,completion: @escaping (AnyObject?)->Void) {
        let postBody =
            [PostModelKey.id.rawValue :postId]

        do {
            try self.runPOSTWithBody(postBody,
                                     endPoint: UrlEndPoints.getMessages.rawValue,
                                     responseDataKey: ResponseDataKey.messages.rawValue ,
                                     completionHandler: completion)
        } catch {
            print("\(ExceptionMessage.couldNotLoadMessages.rawValue) \(error)")
        }
        
        
    }
    
    //MARK :- Send Message
    func sendMessages(message: Message,completion: @escaping ((Int?))->Void) {
        if let person = message.messagedPerson {
            let postBody =
                [PostModelKey.id.rawValue :message.postId, MessagesModelKey.messagedPersonID.rawValue:person.id, MessagesModelKey.description.rawValue:message.messageDescription, MessagesModelKey.messageTime.rawValue:SFUtility.getMessageStringFromDate(date: message.messagedTime)! ] as [String : Any]
            
            do {
                try self.runPOSTWithBody(postBody,
                                         endPoint: UrlEndPoints.postMessage.rawValue,
                                         responseDataKey:ResponseDataKey.messageId.rawValue ,
                                         completionHandler: completion)
            } catch {
                print("\(ExceptionMessage.couldNotSendMessage.rawValue) \(error)")
            }
            
        }
    }
    
    
    //MARK :- updatePostStatus
    func updatePostStatus(postStatus: (postId:Int, status:Int),
                          completion: @escaping ((String?))->Void) {
        let postBody =
            [PostModelKey.id.rawValue:postStatus.postId, PostModelKey.statusCode.rawValue :postStatus.status]

        do {
            try self.runPOSTWithBody(postBody,
                                     endPoint: UrlEndPoints.updatePostStatus.rawValue,
                                     responseDataKey: ResponseDataKey.status.rawValue,
                                     completionHandler: completion)
        } catch {
            print("\(ExceptionMessage.couldNotUpdatePostStatus.rawValue) \(error)")
        }
        
        
    }
    
    //MARK:- Upload Images
    func randomStringWithLength (_ len : Int) -> String {
        
        let letters : String = StringConstant.lettersFormat.rawValue
        var randomString = StringConstant.emptyString.rawValue
        
        for _ in 0..<len {
            let length = UInt32(letters.characters.count)
            let rand = Int(arc4random_uniform(length))
            let char = letters[letters.characters.index(letters.startIndex, offsetBy: rand)]
            randomString.append(char)
        }
        
        return randomString
    }
    
    func getDataStringFromImage(_ imageData: Data) -> String {
        let imageString = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return imageString
    }
    
    func uploadNewPostImages(_ postID: Int,
                             personID: String,
                             uploadPhotoArray: [Data], completionHandler: @escaping ((String?)) ->Void) {
        
        var imageArray = [[String:String]]()
        
        //creating dictionary for images to upload
        for data in uploadPhotoArray {
            var name = randomStringWithLength(3)
            print(name)
            name = name + ImageNames.imageType.rawValue
            
            var imageSubDict1 = [String:String]()
            imageSubDict1[ImageNames.imageName.rawValue] = name
            imageSubDict1[ImageNames.imageData.rawValue] = getDataStringFromImage(data)
            imageSubDict1[ImageNames.imageFlag.rawValue] = StringConstant.characterConstant.rawValue
            imageArray.append(imageSubDict1)
        }
        
        let postBody = [PersonModelKey.id.rawValue: personID,
                        PostModelKey.id.rawValue: postID,
                        PostModelKey.postArray.rawValue: imageArray] as [String : Any]
        
        do {
            try self.runPOSTWithBody(postBody,
                                     endPoint: UrlEndPoints.uploadImage.rawValue,
                                     responseDataKey: ResponseDataKey.status.rawValue,
                                     completionHandler: completionHandler)
        } catch {
            print("\(ExceptionMessage.userIsNotRegister.rawValue) \(error)")
        }
    }
    
    //MARK:- Download image
    
    func downlaodImages(postID: Int,completion: @escaping ([[String:String]]?)->Void) {
        let postBody = [PostModelKey.id.rawValue:postID] as [String : Any]
        
        do {
            try runPOSTWithBody(postBody,
                                endPoint: UrlEndPoints.downloadImage.rawValue,
                                responseDataKey: StringConstant.postImage.rawValue,
                                completionHandler: completion)
        } catch {
            print("\(ExceptionMessage.userIsNotRegister.rawValue) \(error)")
        }
    }
    
    //MARK:- LikesFood
    func likeFood(_postId:Int , onCompletionHandlr :@escaping ((String?)) ->Void ) {
        let postBody = [PostModelKey.id.rawValue :_postId ]
        do {
            try runPOSTWithBody(postBody,
                                endPoint: UrlEndPoints.likesFood.rawValue,
                                responseDataKey: ResponseDataKey.status.rawValue,
                                completionHandler: onCompletionHandlr)
        } catch {
            print("\(ExceptionMessage.userIsNotRegister.rawValue) \(error)")
        }
    }
    
    func editProfileImage(_ person: Person,
                          profilePicData: Data,
                          completionHandler: @escaping (String?) -> Void) {
        
        let imagebase64String = getDataStringFromImage(profilePicData)
        if let personName = person.name {
            let postBody = [PersonModelKey.id.rawValue: person.id,
                            PersonModelKey.firstName.rawValue: personName.firstName,
                            PersonModelKey.lastName.rawValue: personName.lastName,
                            StringConstant.profileImage.rawValue:imagebase64String,
                            PersonModelKey.phoneNumber.rawValue:person.phoneNumber]
            
            do {
                try runPOSTWithBody(postBody,
                                    endPoint: UrlEndPoints.updateProfilePic.rawValue,
                                    responseDataKey: StringConstant.success.rawValue as String,
                                    completionHandler: completionHandler)
                
            } catch {
                print("\(ExceptionMessage.couldNotEditProfileImage.rawValue) \(error)")
            }
        }
    } */
    
}


extension VMServiceRequestManager {
    
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    func getSpotFoodBaseRequestURL() -> String {
        
        return VMUtil.configuration.isLocal ? VMUtil.configuration.localBaseRequestURL : VMUtil.configuration.remoteBaseRequestURL
    }
}


