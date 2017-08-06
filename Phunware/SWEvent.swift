//
//  SWEvent.swift
//  Phunware
//
//  Created by Brandon on 8/4/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation

class SWEvent {
    
    var photosManager: PhotosManager { return .shared }

    var id: Int?
    var description: String?
    var title: String?
    var timeStamp: String?
    var imageURL: String?
    var date: String?
    var locationline1: String?
    var locationline2: String?
    
    init(json: NSDictionary) {
        id = json["id"] as? Int
        description = json["description"] as? String
        title = json["title"] as? String
        timeStamp = json["timeStamp"] as? String
        imageURL = json["image"] as? String
        date = json["date"] as? String
        locationline1 = json["locationline1"] as? String
        locationline2 = json["locationline2"] as? String
    }
}
