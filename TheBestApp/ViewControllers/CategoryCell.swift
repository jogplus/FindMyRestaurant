//
//  CategoryCell.swift
//  TheBestApp
//
//  Created by Sanskar Gyawali on 3/8/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
