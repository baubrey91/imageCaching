//
//  ViewController.swift
//  Phunware
//
//  Created by Brandon on 8/4/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let serviceURL = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    let imageCache = AutoPurgingImageCache()

    var events = [SWEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.sharedInstance.getSWEvents(url: serviceURL, completionHandler: {
            json in DispatchQueue.main.sync {
                let payload = json as! [[String: Any]]
                for event in payload {
                    self.events.append(SWEvent(json: event as NSDictionary))
                    self.collectionView.reloadData()
                }
            }
        })
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let vc = segue.destination as! DetailViewController
            let indexPath = collectionView.indexPath(for: sender as! SWCollectionViewCell)!
            vc.imgURL = events[indexPath.row].imageURL
            
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        let width = (deviceIdiom == .pad) ? (Int(self.view.frame.width) / 2) : Int(self.view.frame.width)
        let height = 160
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "swCell", for: indexPath) as! SWCollectionViewCell
        
        cell.event = events[indexPath.row]
        
        return cell
    }
}

