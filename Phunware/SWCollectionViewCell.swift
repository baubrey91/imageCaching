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
    
    var imgURL: String?
    
    var request: Request?
    
    var photosManager: PhotosManager { return .shared }
    
    var event: SWEvent! {
        didSet {
            dateLabel.text = event.date
            titleLabel.text = event.title
            locationLabel.text = event.locationLine
            descriptionLabel.text = event.description
            if let imsString = event.imageURL {
                imgURL = imsString
                loadImage()
            }
        }
    }
    
    func loadImage() {
        if let image = photosManager.cachedImage(for: imgURL!) {
            populate(with: image)
            return
        }
        downloadImage()
    }
    
    func downloadImage() {
        //loadingIndicator.startAnimating()
        request = photosManager.retrieveImage(for: imgURL!) { image in
            self.populate(with: image)
        }
    }
    
    func populate(with image: UIImage) {
        //loadingIndicator.stopAnimating()
        imageBackground.image = image
    }
}



