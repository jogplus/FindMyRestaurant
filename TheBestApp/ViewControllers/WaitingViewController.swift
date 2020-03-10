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
