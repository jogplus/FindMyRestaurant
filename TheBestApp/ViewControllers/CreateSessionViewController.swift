//
//  CreateSessionViewController.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/5/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import Parse

class CreateSessionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startSession(_ sender: Any) {
        let code = Int.random(in: 10000 ..< 99999)
        var user = PFUser()
        user.username = String(code)
        user.password = String(code)
        user["userCount"] = 1
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "sessionHostSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
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
