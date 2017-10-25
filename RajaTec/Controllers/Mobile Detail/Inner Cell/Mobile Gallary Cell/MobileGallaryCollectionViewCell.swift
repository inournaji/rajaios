//
//  MobileGallaryCollectionViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class MobileGallaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mobileDetailImageView: UIImageView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    var itemImageURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(imageLink: String?) {
        
        if let imageLink = imageLink, let imageUrl = URL(string: imageLink) {
            
            self.itemImageURL = imageUrl
            
            self.imageActivityIndicator.startAnimating()
            
            self.mobileDetailImageView.kf.setImage(with: imageUrl, completionHandler: { (image, error, cached, url) in
                
                if url == self.itemImageURL {
                    
                    self.imageActivityIndicator.stopAnimating()
                    
                }
                
            })
            
        }
        
    }
    
}
