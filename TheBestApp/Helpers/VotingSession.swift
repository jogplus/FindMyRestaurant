//
//  UserHelpers.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/5/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import Foundation
import Parse

class VotingSession {
    static func createSession(closure: @escaping (Bool, Error?) -> Void){
        let code = Int.random(in: 10000 ..< 99999)
        let session = PFUser()
        session.username = String(code)
        session.password = String(code)
        session["userCount"] = 1
        session.signUpInBackground {(succes, error) in
            closure(succes, error)
        }
    }
    
    static func joinSession(sessionId: String, closure: @escaping (PFUser?, Error?) -> Void) {
        PFUser.logInWithUsername(inBackground: sessionId, password: sessionId) {(succes, error) in
            closure(succes, error)
        }
    }
    
    static func incrementUserCount(closure: @escaping (Bool, Error?) -> Void) {
        let session = PFUser.current()!
        let userCount = Int(truncating: session["userCount"] as! NSNumber) + 1
        PFUser.current()!.setObject(userCount, forKey: "userCount")
        PFUser.current()!.saveInBackground {(succes, error) in
            closure(succes, error)
        }
    }
    
    static func decrementUserCount(closure: @escaping (Bool, Error?) -> Void) {
        let session = PFUser.current()!
        let userCount = Int(truncating: session["userCount"] as! NSNumber) - 1
        PFUser.current()!.setObject(userCount, forKey: "userCount")
        PFUser.current()!.saveInBackground {(succes, error) in
            closure(succes, error)
        }
    }
    
    static func getUserCount() -> NSNumber {
        let session = PFUser.current()!
        session.fetchInBackground()
        return session["userCount"] as! NSNumber
    }
}

