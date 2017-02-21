//
//  Constants.swift
//  spotFood
//
//  Created by basagond a mugganauar on 02/01/17.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

let longPressGestureMinDuration = 0.2

enum ServerError:Error {
    case serverDown
    case responseKeyNotFound
    case error
    case invalidJSON
}


enum ErrorKeys: String {
    case emptyPhoneNumber = "Phone Number is empty"
    case firstNameShort = "First Name should have minimum 4 characters"
    case lastNameShort = "Last Name should have minimum 2 characters"
    case tryAgain = "Try Again!!!"
    case failure = "Failure"
    case cameraError = "Camera is not supproted in simulator."
    case alertError = "Error"
    case serverError = "Server Error"
    case serverResponse = "\nNo Response From Server"
    case errorMessage = "errorMessage"
    case fatalError = "init(coder:) has not been implemented"
    case couldNotInitialize = "Could not initialize due to error:"
}

enum VoterModelKey: String {
    case leadVoterId = "leadVoterId"
    case role = "role"
    case voterId = "voterId"
    case name = "name"
    case voterName = "voterName"
    case familyRole = "familyRole"
    case address = "address"
    case wardName = "wardName"
    case wardNo = "wardNo"
    case member = "member"
    case status = "status"
    case voters = "voters"
    case limit = "limit"
    case offset = "offset"
    
}

enum MessagesModelKey:String {
    case id = "messageId"
    case description = "description"
    case postId  = "postId"
    case messageTime = "messageTime"
    case messagedPerson = "person"
    case messagedPersonID = "messagedPersonId"
    
}

enum PostModelKey :String {
    case id = "postId"
    case eventName = "eventName"
    case description = "description"
    case postedBy = "postedBy"
    case locationLatitude = "locationLatitude"
    case locationLongitude = "locationLongitude"
    case floorNo = "floorNo"
    case buildingName = "buildingName"
    case noOfLikes = "noOfLikes"
    case message = "message"
    case status = "status"
    case availableFromTime = "availableFromTime"
    case foodImages = "food_images"
    case statusCode = "statusCode"
    case postArray = "imageDictArray"
}

enum StringConstant: String {
    case accessGroup = "group.com.exilant.EXILANTApps"
    case main = "Main"
    case validUser = "validUser"
    case success = "success"
    case failure = "Failure"
    case availableFrom = "Available from "
    case eventName = "Event Name"
    case foodDescription = "Description"
    case imageStringData = "ImageStringData"
    case emptyString = ""
    case noBuildingName = "Buiding name and floor number not available"
    case editLocation = "Edit location"
    case description = "Description..."
    case ok = "OK"
    case characterConstant = "A"
    case cancel = "Cancel"
    case done = "Done"
    case edit = "Edit"
    case postedSucessfully = "Posted  Successfully!!!"
    case back = "Back"
    case takePhoto = "Take Photo"
    case takeAnotherPhoto = "Take Another Photo"
    case photoLibrary = "Photo Library"
    case alertMessage = "Are you sure you want to discard this changes"
    case signOutMessage = "Are you sure you want to SignOut"
    case alertType = "Alert"
    case postAvalibility = "No posts available"
    case proficMissing = "Profile Pic Missing!!!"
    case updateProfilePic = "Please update your profile picture before making the first post"
    case loginToApp =  "Login to Spot Food"
    case pinId = "pin"
    case newLine = "\n"
    case search = "Search"
    case commaWithSpace = ", "
    case comma = ","
    case postedBy = "Posted By:"
    case location = "Location"
    case geoLocationCoordinate = "geoLocationCoordinate"

    case requestBody = "requestBody:"
    case post = "post"
    case haschangedstatus =  "has changed status icon from"
    case chooseLocation = "Choose Location "
    case profileImage = "image"
    case postImage = "images"
    case lettersFormat = "abcdefghijkmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUXYZ0123456789"
    case symbolicFormat = "%@%@%@%@%@%@%@"

}

enum ExceptionMessage: String {
    case userIsNotRegister = "Could not register user due to error:"
    case validateUserReqbody = "validate user reqbody:"
    case userIsNotValidate = "Could not validate user due to error:"
    case createPostReqbody = "create post reqbody:"
    case couldNotCreatePost = "Could not create post due to error:"
    case editPostReqbody = "edit post reqbody:"
    case couldNotEditPost = "Could not edit post due to error:"
    case couldNotLoadAllPosts = "Could not load all posts due to error:"
    case couldNotLoadMyPosts = "Could not load my posts due to error:"
    case getMyPostsReqbody = "getMyPosts reqbody:"
    case couldNotLoadMyInfo = "Could not load myInfo due to error:"
    case getMessages = "Get Messages :"
    case couldNotLoadMessages = "Could not load messages due to error:"
    case couldNotSendMessage = "Could not send message due to error:"
    case couldNotUpdatePostStatus = "Could not update Post Status due to error:"
    case updatedLikes = "UpdatedLikes:"
    case couldNotEditProfileImage = "Could not edit profile image due to error:"
}

enum FoodStatus : String {
    case available = "available"
    case over = "gone"
    case gettingOver = "getting over"
}

enum ImageNames: String {
    case plus = "Plus"
    case defaultFoodIcon = "food1"
    case goneFood = "Gone_food"
    case imageDetails = "Image not found"
    case delete = "Delete"
    case grayColor = "CIPhotoEffectMono"
    case available = "available"
    
    case imageName = "imageName"
    case imageData = "imageData"
    case imageFlag = "flag"
    case imageType = ".png"
    case gettingOver = "getting_over"
    case over = "over"
    case defaultProfileImage = "Profile"    
}

enum TableViewCellIdentifiers: String {
    case chatCell = "chatCell"
    case searchCell = "searchCell"
    case myPostCell = "myPostCell"
    case foodCell = "foodCell"
    case cell = "cell"
}

enum CollectionViewCellIdentifiers: String {
    case foodPic = "foodPic"
}

enum SegueIdentifier :String {
    case showEventDetail = "ShowEventDetail"
    case postFood = "PostFood"
    case editPost = "editPost"
    case listView = "ListView"
}

enum StoryBoardidentifier :String {
    case calloutView = "SFCustomCalloutView"
    case locationSearch = "SFLocationSearchTable"
    case register = "SFRegisterIdentifier"
    case mapView = "SFMapVCIdentifier"
    case searchpost = "SFSearchDisplayTableViewController"
    case popOver = "SFPopover"
    case storyBoardId = "Home"
}

enum LocationKeys :String {
    case name = "Name"
    case street = "Street"
    case state = "State"
    case city = "City"
    case places = "Search for places"
    case placeType = "Unknown Place"
}

enum UrlEndPoints: String {
    case AddVoter = "voter-add"
    case GetVoterList = "voter-list"
}

enum ResponseDataKey: String {
    case status = "status"
    case postId = "PostId"
    case allPosts = "all_posts"
    case myPosts = "my_posts"
    case details = "Details"
    case messages = "Messages"
    case messageId = "messageId"
}

enum ConfigKeys: String {
    case VoteMeKeysPlistName = "VoteMe"
    case appRouteLocal = "appRouteLocal"
    case isLocalKey = "isLocal"
    case appRouteRemote = "appRouteRemote"
}

enum HTTPHeaderContentTypeValues : String {
    case json = "application/json"
}

enum HTTPHeaderFields : String {
    case contentType = "Content-Type"
    case accept = "Accept"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

}
