//
//  DetailViewController.swift
//  Phunware
//
//  Created by Brandon Aubrey on 8/4/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var photosManager: PhotosManager { return .shared }
    var imgURL: String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }

    func loadImage() {
        if let image = photosManager.cachedImage(for: imgURL!) {
            imageView.image = image
        }
    }
}

