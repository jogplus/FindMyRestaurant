//
//  File.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/8/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CategoryCellDesignView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    
    @IBInspectable var shadowOpacity: Float = 0.2
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        
        layer.shadowOpacity = shadowOpacity
    }

}
