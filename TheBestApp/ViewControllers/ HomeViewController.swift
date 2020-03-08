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
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

}

