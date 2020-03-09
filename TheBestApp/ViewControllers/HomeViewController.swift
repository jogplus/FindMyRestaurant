//
//  ViewController.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/3/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradient = CAGradientLayer()
//
//        gradient.frame = self.view.bounds
//        let firstColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
//        let secondColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
//        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
//
//        self.view.layer.insertSublayer(gradient, at: 0)
        
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

