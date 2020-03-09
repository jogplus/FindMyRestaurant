//
//  JoinSessionViewController.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/5/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import Parse

class JoinSessionViewController: UIViewController {

    
    @IBOutlet weak var sessionIDTextField: UITextField!
    @IBOutlet weak var validSessionLabel: UILabel!
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func onType(_ sender: Any) {
        validSessionLabel.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validSessionLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func joinSession(_ sender: Any) {
        let sessionId = sessionIDTextField.text!
        VotingSession.joinSession(sessionId: sessionId, closure: { (session, error) in
            if session != nil {
                self.performSegue(withIdentifier: "sessionJoinSeg", sender: nil)
                print("we were successful")
            } else {
                self.validSessionLabel.isHidden = false
                print("this is bad")
            }
        }) 
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
