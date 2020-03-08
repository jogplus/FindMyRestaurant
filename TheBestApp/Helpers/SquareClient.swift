//
//  YelpClient.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/7/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import Foundation

class SquareClient {
    static var CLIENT_ID = "QA1L0Z0ZNA2QVEEDHFPQWK0I5F1DE3GPLSNW4BZEBGJXUCFL"
    static var CLIENT_SECRET = "W2AOE1TYC4MHK5SZYOUGX0J3LVRALMPB4CXT3ZH21ZCPUMCU"
    
    static func fetchCategories() {
        let baseUrlString = "https://api.foursquare.com/v2/venues/search?"
        let queryString = "client_id=\(SquareClient.CLIENT_ID)&client_secret=\(SquareClient.CLIENT_SECRET)&v=20141020&near=Irvine,CA&query=restaurant"

        let url = URL(string: baseUrlString + queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let request = URLRequest(url: url)

        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                        let restaurants = responseDictionary.value(forKeyPath: "response.venues") as! NSArray
                        
                        var categoriesSet = Set<String>()
                        for restaurant in restaurants as! [NSDictionary] {
                            
                            let categories = restaurant.value(forKeyPath: "categories")
                            
                            for category in categories as! [NSDictionary] {
                                categoriesSet.insert(category.value(forKeyPath: "name") as! String)
                            }
                        }
                    }
                }
        });
        task.resume()
    }
}
