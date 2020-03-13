//
//  InfoSessionViewController.swift
//  TheBestApp
//
//  Created by Tristan Jogminas on 3/5/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import Parse

class InfoSessionViewController: UIViewController {

    @IBOutlet weak var sessionCodeLabel: UILabel!
    @IBOutlet weak var sessionCountLabel: UILabel!
    @IBOutlet weak var sessionCountSubLabel: UILabel!
    @IBOutlet weak var sessionCodeSubLabel: UILabel!
    @IBOutlet weak var startVoteButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if VotingSession.loadedCategories == false {
            
            sessionCodeLabel.isHidden = true
            sessionCountLabel.isHidden = true
            sessionCodeSubLabel.isHidden = true
            sessionCountSubLabel.isHidden = true
            startVoteButton.isHidden = true
            loadingView.isHidden = false
            
            VotingSession.createSession { (success, error) in
                if success {
                    self.sessionCodeLabel.text = VotingSession.getSessionId()
                    self.sessionCodeLabel.isHidden = false
                    self.sessionCountLabel.isHidden = false
                    self.sessionCodeSubLabel.isHidden = false
                    self.sessionCountSubLabel.isHidden = false
                    self.startVoteButton.isHidden = false
                    self.loadingView.isHidden = true
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateUserCount), userInfo: nil, repeats: true)
                    
                    VotingSession.loadedCategories = true
                                    
                    SquareClient.fetchCategories(location: VotingSession.location, radius: VotingSession.radius, price: VotingSession.price) { (categories) in
                        VotingSession.saveSessionCategories(categories: categories) { (success, error) in
                            if success {
                                print("it did work")
                            } else {
                                print("no it did not work")
                            }
                        }
                    }
                }
                else {
                    print("Error: \(error?.localizedDescription ?? "bad news")")
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        
        if self.isMovingFromParent {
            VotingSession.decrementUserCount{ (success, error) in
                if success {
                    print("we were successful")
                    VotingSession.sessionCreater = false
                } else {
                    print("this is bad")
                }
            }
        }
    }
    
    @objc func updateUserCount() {
        sessionCountLabel.text = String(format: "%@", VotingSession.getUserCount())
    }
    
    @IBAction func beginVoting(_ sender: Any) {
        VotingSession.startSessionVoting{ (success, error) in
            if success {
                print("voting is starting")
                self.performSegue(withIdentifier: "CreatorBeginVoting", sender: nil)
            } else {
                print("there was and error\(String(describing: error))")
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
