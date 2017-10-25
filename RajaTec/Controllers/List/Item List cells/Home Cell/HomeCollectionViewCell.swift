//
//  HomeCollectionViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation


class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dealImage: UIImageView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dealTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: Offer) {
        
        self.dealTitle.text = offer.title
        
        if let image = offer.image, let imageURL = URL(string: image) {
            
            self.imageActivityIndicator.startAnimating()
            
            self.dealImage.kf.setImage(with: imageURL, completionHandler: { (image, error, cached, url) in
                
                self.imageActivityIndicator.stopAnimating()
                
            })
            
        }
        
    }
    
}
