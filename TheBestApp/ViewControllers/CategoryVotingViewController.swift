//
//  CategoryVotingViewController.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/9/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CategoryVotingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var categoryArray = [PFObject]()
    
    @IBAction func submitVoteOnPress(_ sender: Any) {
        let selctedIndex = tableView.indexPathForSelectedRow
        if selctedIndex != nil {
            self.performSegue(withIdentifier: "WaitingViewSegue", sender: nil)
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @objc func loadCategories() {
        
        VotingSession.getSessionCategories { (categories, error) in
            if categories != nil {
                self.categoryArray = categories!
                self.tableView.reloadData()
            } else {
                print("it did not work: \(String(describing: error))")
            }
            
        }
//        SquareClient.fetchCategories(location: VotingSession.location, radius: VotingSession.radius) { (categories) in
//            self.categoryArray = categories
//            
//            self.tableView.reloadData()
//        }
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
//        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let categoryDict = categoryArray[indexPath.row]
        cell.categoryLabelView.text = categoryDict["shortName"] as? String
        
        let iconURL = URL(string: categoryDict["iconURL"] as! String)
        
        cell.categoryImageView.af.setImage(withURL: iconURL!)
        cell.categoryImageView.backgroundColor = UIColor.systemBlue
        cell.categoryImageView.layer.cornerRadius = 12
        
        return cell
    }

}
