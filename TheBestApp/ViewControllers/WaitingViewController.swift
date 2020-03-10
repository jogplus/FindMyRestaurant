//
//  WaitingViewController.swift
//  TheBestApp
//
//  Created by Tristan Jogminas on 3/9/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import Lottie

class WaitingViewController: UIViewController {

    @IBOutlet weak var lottieView: UIView!
    let animationView = AnimationView()
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let myFile = Bundle.main.path(forResource: "1342-location", ofType: "json")
        else {
            print("error getting json")
            return
        }
        
        animationView.animation = Animation.filepath(myFile)
        
        //if this is true, there will be autolayout conflicts
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        //set the animation to loop
        animationView.loopMode = .loop
        
        //add to animation into container
        lottieView.addSubview(animationView)
        
        //Pin Animation(childView) to edges of container(parentView)
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: lottieView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: lottieView.bottomAnchor)
        ])

        
        animationView.play()
        
        if VotingSession.sessionCreater {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.votesFinished), userInfo: nil, repeats: true)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.restaurantFound), userInfo: nil, repeats: true)
        }
    }
    
    @objc func votesFinished() {
        VotingSession.getVotes { (votes, error) in
            if votes != nil && votes!.count >= Int(truncating: VotingSession.getUserCount()) {
                VotingSession.getRemainingCategories { (categories, error) in
                    print(categories)
                    if categories != nil {
                        print("getting rest")
                        SquareClient.fetchRestaurants(location: VotingSession.location, radius: VotingSession.radius, categories: categories! as NSArray) { (restaurants) in
                            print(restaurants)
                            if restaurants.count > 0 {
                                print(restaurants)
                                
                                let finalRestaurant = restaurants.randomElement()
                                let finalRestaurantId = finalRestaurant?.value(forKey: "id")
                                VotingSession.saveFinalRestaurant(restaurantId: finalRestaurantId as! String) { (success, error) in
                                    if success {
                                        print("we picked a restaurant")
                                        self.performSegue(withIdentifier: "FinalRestaurantSeg", sender: nil)
                                    } else {
                                        print("there was an error \(String(describing: error))")
                                    }
                                }
                            }
                            
                        }
                    } else {
                        print("there was an error: \(String(describing: error))")
                    }
                }
            }
        }
    }
    
    @objc func restaurantFound() {
        if VotingSession.getFinalRestaurant() != nil {
            self.performSegue(withIdentifier: "FinalRestaurantSeg", sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
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
