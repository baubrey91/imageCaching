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
    var eventDescription: String?
    var eventDate: String?
    var eventTitle: String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        eventDateLabel.text = eventDate
        eventDescriptionLabel.text = eventDescription
        eventTitleLabel.text = eventTitle
        if let img = imgURL, let image = photosManager.cachedImage(for: img) {
            imageView.image = image
        }
        let texth = textView.frame.height
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height + texth
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        if let details = eventDescription {
            let activityViewController = UIActivityViewController(activityItems: [details], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}

