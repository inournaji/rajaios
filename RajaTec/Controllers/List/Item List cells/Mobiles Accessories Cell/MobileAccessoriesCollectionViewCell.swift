//
//  MobileAccessoriesCollectionViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/1/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import Kingfisher

class MobileAccessoriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    //MARK: - Variables
    var itemImageURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(mobile: Mobile) {
        
        self.itemNameLabel.text = mobile.title
        
        self.itemPriceLabel.text = mobile.price
        
        if let image = mobile.image?.first, let imageURL = URL(string: image) {
            
            self.itemImageURL = imageURL
            
            self.imageActivityIndicator.startAnimating()
            
            self.itemImageView.kf.setImage(with: imageURL, completionHandler: { (image, error, cached, url) in
                
                if url == self.itemImageURL {
                    
                    self.imageActivityIndicator.stopAnimating()
                    
                }
                
            })
            
        }
        
    }
    
    func configureCell(accessoryItem: Accessory) {
        
        self.itemNameLabel.text = accessoryItem.title
        
        self.itemPriceLabel.text = accessoryItem.price
        
        if let image = accessoryItem.image, let imageURL = URL(string: image) {
            
            self.itemImageURL = imageURL
            
            self.imageActivityIndicator.startAnimating()
            
            self.itemImageView.kf.setImage(with: imageURL, completionHandler: { (image, error, cached, url) in
                
                if url == self.itemImageURL {
                    
                    self.imageActivityIndicator.stopAnimating()
                    
                }
                
            })
            
        }
        
    }
    
}

