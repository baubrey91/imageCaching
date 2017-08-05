//
//  PhotosManager.swift
//  Phunware
//
//  Created by Brandon Aubrey on 8/4/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UInt64 {
    
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
    
}

class PhotosManager {
    
    static let shared = PhotosManager()
//    
//    private var dataPath: String {
//        return Bundle.main.path(forResource: "GlacierScenics", ofType: "plist")!
//    }
//    
//    lazy var photos: [Photo] = {
//        var photos = [Photo]()
//        guard let data = NSArray(contentsOfFile: self.dataPath) as? [[String: Any]] else { return photos }
//        for info in data {
//            let photo = Photo(info: info)
//            photos.append(photo)
//        }
//        return photos
//    }()
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    //MARK: - Image Downloading
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
            self.cache(image, for: url)
        }
    }
    
    //MARK: - Image Caching
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
}

struct Photo {
    
    let name: String
    let url: String
    
    init(info: [String: Any]) {
        self.name = info["name"] as! String
        self.url = info["imageURL"] as! String
    }
}
