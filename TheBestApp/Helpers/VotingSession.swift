//
//  UserHelpers.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/5/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import Foundation
import Parse
import MapKit

class VotingSession {
    static var sessionCreater: Bool = false
    static var price: Int = -1
    static var radius: CLLocationDistance = 0
    static var location: CLLocation = CLLocation()
    
    static func createSession(closure: @escaping (Bool, Error?) -> Void){
        let code = Int.random(in: 10000 ..< 99999)
        let session = PFUser()
        session.username = String(code)
        session.password = String(code)
        session["userCount"] = 1
        session["canVote"] = false
        session.signUpInBackground {(success, error) in
            if success {
                VotingSession.sessionCreater = true
            }
            closure(success, error)
        }
    }
    
    static func joinSession(sessionId: String, closure: @escaping (PFUser?, Error?) -> Void) {
        PFUser.logInWithUsername(inBackground: sessionId, password: sessionId) {(success, error) in
            closure(success, error)
        }
    }
    
    static func incrementUserCount(closure: @escaping (Bool, Error?) -> Void) {
        let session = PFUser.current()!
        let userCount = Int(truncating: session["userCount"] as! NSNumber) + 1
        PFUser.current()!.setObject(userCount, forKey: "userCount")
        PFUser.current()!.saveInBackground {(success, error) in
            closure(success, error)
        }
    }
    
    static func decrementUserCount(closure: @escaping (Bool, Error?) -> Void) {
        let session = PFUser.current()!
        let userCount = Int(truncating: session["userCount"] as! NSNumber) - 1
        PFUser.current()!.setObject(userCount, forKey: "userCount")
        PFUser.current()!.saveInBackground {(success, error) in
            closure(success, error)
        }
    }
    
    static func getUserCount() -> NSNumber {
        let session = PFUser.current()!
        session.fetchInBackground()
        return session["userCount"] as! NSNumber
    }
    
    static func saveSessionCategories(categories: [NSDictionary], closure: @escaping (Bool, Error?) -> Void) {
        
        for category in categories {
            let newCategory = PFObject(className: "Category")
            
            newCategory["sessionId"] = PFUser.current()!
            newCategory["catId"] = category.value(forKey: "id")
            newCategory["name"] = category.value(forKey: "name")
            newCategory["pluralName"] = category.value(forKey: "pluralName")
            newCategory["shortName"] = category.value(forKey: "shortName")
            
            let icon = category.value(forKey: "icon") as? NSDictionary
            let prefix = icon?.value(forKey: "prefix") as? String
            let suffix = icon?.value(forKey: "suffix") as? String
            if (prefix != nil && suffix != nil) {
                newCategory["iconURL"] = prefix! + "88" + suffix!
            }
            
            newCategory.saveInBackground { (success, error) in
                if success != true {
                    closure(success, error)
                    return
                }
            }
        }
        
        closure(true, nil)
    }
    
    static func getSessionCategories(closure: @escaping ([PFObject]?, Error?) -> Void) {
        let query = PFQuery(className: "Category")
        query.whereKey("sessionId", equalTo: PFUser.current()!)
        
        query.findObjectsInBackground { (categories, error) in
            closure(categories, error)
        }
    }
    
    static func startSessionVoting(closure: @escaping (
        Bool, Error?) -> Void) {
        PFUser.current()!.setObject(true, forKey: "canVote")
        PFUser.current()!.saveInBackground {(success, error) in
           closure(success, error)
        }
    }
    
    static func canVote() -> Bool {
        let session = PFUser.current()!
        return session["canVote"] as! Bool
    }
    
    static func getSessionId() -> String {
        return PFUser.current()!.username!
    }
    
    static func sendVote() {
        return
    }
    
    static func selectWinner() {
        return
    }
}

