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

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    //MARK: - Image Downloading
    func retrieveImage(for url: String, completion: @escaping (Any) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            //print(response.error)
            guard let image = response.result.value else { return completion(response.error)}
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
