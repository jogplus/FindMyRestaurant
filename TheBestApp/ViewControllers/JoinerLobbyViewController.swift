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

    
    @IBOutlet weak var sessionCountLabel: UILabel!
    
    var userTimer : Timer!
    var voteTimer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VotingSession.incrementUserCount{ (success, error) in
            if success {
                print("we were successful")
            } else {
                print("this is bad")
            }
        }
        
        userTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateUserCount), userInfo: nil, repeats: true)
        
        voteTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.checkVotingStatus), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userTimer?.invalidate()
        voteTimer?.invalidate()

        if self.isMovingFromParent {
            VotingSession.decrementUserCount{ (success, error) in
                if success {
                    print("we were successful")
                } else {
                    print("this is bad")
                }
            }
        }
    }
    
    @objc func updateUserCount() {
        sessionCountLabel.text = String(format: "%@", VotingSession.getUserCount())
    }
    
    @objc func checkVotingStatus() {
        if VotingSession.canVote() {
            self.performSegue(withIdentifier: "JoinerBeginVoting", sender: nil)
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
