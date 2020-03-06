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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sessionCodeLabel.text = VotingSession.getSessionId()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateUserCount), userInfo: nil, repeats: true)
    }
    
    @objc func updateUserCount() {
        sessionCountLabel.text = String(format: "%@", VotingSession.getUserCount())
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
