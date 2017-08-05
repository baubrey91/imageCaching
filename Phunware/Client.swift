//
//  Client.swift
//  Phunware
//
//  Created by Brandon on 8/4/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation

class Client {
    
    static let sharedInstance = Client()
    
    func getSWEvents(url: String, completionHandler: @escaping ((_ json: AnyObject) -> Void)) {
        let nsURL = URL(string: url)!
        let session = URLSession.shared
        let task = session.dataTask(with: nsURL, completionHandler: { data, response, error -> Void in
            if error != nil {
                completionHandler(error as AnyObject)
            }
            if data != nil {
                let jsonData = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [[String:Any]]
                completionHandler(jsonData as AnyObject)
            }
            session.invalidateAndCancel()
            })
        task.resume()
    }
}
