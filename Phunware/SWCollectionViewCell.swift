//
//  SWCollectionViewCell.swift
//  Phunware
//
//  Created by Brandon on 8/4/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SWCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var isLoadingView: UIView!
    
    var imgURL: String?
    
    var request: Request?
    
    //var targetCell: SWCollectionViewCell?
    
    var photosManager: PhotosManager { return .shared }
    
    var event: SWEvent! {
        didSet {
            if let d = event.date {
                setDate(d: d)
            }
            titleLabel.text = event.title
            if let loc1 = event.locationline1, let loc2 = event.locationline2 {
                let location = "\(loc1), \(loc2))"
                locationLabel.text = location
            }
            
            descriptionLabel.text = event.description
            reset()

            if let imsString = event.imageURL {
                imgURL = imsString
                loadImage()
            }
        }
    }
    
    func reset() {
        imageBackground.image = nil
        request?.cancel()
    }
    
    func setDate(d: String) {
        let dateFormatter = DateFormatter()
        //"2015-09-08T15:07:00.000Z"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy 'at' h:mm a"
        
        if let date = dateFormatter.date(from: d) {
            dateLabel.text = dateFormatterPrint.string(from: date)
        }
    
    }
    
    func loadImage() {
        if let image = photosManager.cachedImage(for: imgURL!) {
            self.imageBackground.image = image
            return
        }
        
        self.isLoadingView.isHidden = false
        request = photosManager.retrieveImage(for: imgURL!) { image in
            if let img = image as? UIImage {
                self.imageBackground.image = img
                self.isLoadingView.isHidden = true
            } else {
                //error
                print(image)
                self.isLoadingView.isHidden = true
            }
        }
    }
}



