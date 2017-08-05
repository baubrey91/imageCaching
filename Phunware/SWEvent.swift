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
    var locationLine: String?
    var locationLine2: String?
    
    init(json: NSDictionary) {
        id = json["id"] as? Int
        description = json["description"] as? String
        title = json["title"] as? String
        timeStamp = json["timeStamp"] as? String
        imageURL = json["image"] as? String
        date = json["date"] as? String
        locationLine = json["locationLine"] as? String
        locationLine2 = json["locationLine2"] as? String
    }
}
