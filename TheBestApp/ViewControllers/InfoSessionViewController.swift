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
    
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sessionCodeLabel.text = VotingSession.getSessionId()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateUserCount), userInfo: nil, repeats: true)
        
        
        
        SquareClient.fetchCategories(location: VotingSession.location, radius: VotingSession.radius) { (categories) in
            var categoryIds = [String]()
            for category in categories as! [NSDictionary] {
                categoryIds.append(category.value(forKey: "id") as! String)
            }
            
            SquareClient.fetchRestaurants(location: VotingSession.location, radius: VotingSession.radius, categories: categoryIds as NSArray) { (restaurants) in
                let firstRestaurant = restaurants[0] as! NSDictionary
                
                print(restaurants.count)
                
                SquareClient.fetchRestaurantInfo(restaurantId: firstRestaurant.value(forKey: "id") as! String) { (restaurant) in
                    print(restaurant.value(forKey: "name") ?? "")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
