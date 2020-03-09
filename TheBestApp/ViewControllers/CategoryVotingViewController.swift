//
//  CategoryVotingViewController.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/9/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import AlamofireImage

class CategoryVotingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var categoryArray = [NSDictionary]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @objc func loadCategories() {
        SquareClient.fetchCategories(location: VotingSession.location, radius: VotingSession.radius) { (categories) in
            self.categoryArray = categories
            
            self.tableView.reloadData()
        }
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
        
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let categoryDict = categoryArray[indexPath.row]
        cell.categoryLabelView.text = categoryDict.value(forKey: "shortName") as? String
        
        let iconInfo = categoryDict.value(forKey: "icon") as? NSDictionary
        
        let imagePrefix = iconInfo?.value(forKey: "prefix") as? String
        
        let imageSuffix = iconInfo?.value(forKey: "suffix") as? String
        
        
        if (imagePrefix != nil && imageSuffix != nil) {
            let categoryImageURL = URL(string: imagePrefix! + "88" + imageSuffix!)
            
            cell.categoryImageView.af.setImage(withURL: categoryImageURL!)
        }
        
        return cell
    }

}
