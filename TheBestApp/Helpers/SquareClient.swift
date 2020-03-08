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
    
    static var categoryList:NSArray = []
    
    static func fetchCategories() {
        let baseUrlString = "https://api.foursquare.com/v2/venues/categories?"
        let queryString = "client_id=\(SquareClient.CLIENT_ID)&client_secret=\(SquareClient.CLIENT_SECRET)&v=20141020&id=4d4b7105d754a06374d81259"

        let url = URL(string: baseUrlString + queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        
        print(url)
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
                        SquareClient.categoryList = responseDictionary.value(forKeyPath: "response.categories") as! NSArray
//                            self.tableView.reloadData()
                        print(SquareClient.categoryList)

                    }
                }
        });
        task.resume()
    }
    
    func fetchLocations(_ query: String, near: String = "Irvine") {
        let baseUrlString = "https://api.foursquare.com/v2/venues/search?"
        let queryString = "client_id=\(SquareClient.CLIENT_ID)&client_secret=\(SquareClient.CLIENT_SECRET)&v=20141020&near=\(near),CA&query=\(query)"

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
//                            self.results = responseDictionary.value(forKeyPath: "response.venues") as! NSArray
//                            self.tableView.reloadData()

                    }
                }
        });
        task.resume()
    }
}
