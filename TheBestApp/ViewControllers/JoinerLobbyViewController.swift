//
//  JoinerLobbyViewController.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/5/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import Parse

class JoinerLobbyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = PFUser.current()
        let userCount = Int(truncating: session!["userCount"] as! NSNumber) + 1
        PFUser.current()!.setObject(userCount, forKey: "userCount")
        PFUser.current()!.saveInBackground { (success, error) in
            if success {
                print("we were successful")
            } else {
                print("this is bad")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            
            let session = PFUser.current()
            let userCount = Int(truncating: session!["userCount"] as! NSNumber) - 1
            PFUser.current()!.setObject(userCount, forKey: "userCount")
            PFUser.current()!.saveInBackground { (success, error) in
                if success {
                    print("we were successful")
                } else {
                    print("this is bad")
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
