//
//  OfferTableViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/12/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import Kingfisher

class OfferTableViewCell: UITableViewCell {

    //MARK: - Otlets
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerMessageLabel: UILabel!
    @IBOutlet weak var messageTopCons: NSLayoutConstraint!
    @IBOutlet weak var offerImageHeightCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferNotification) {
        
        self.offerMessageLabel.text = offer.message
        
        if let imageURL = offer.image {
            
            self.messageTopCons.constant = 10
            self.offerImageHeightCons.constant = 130
            
            offerImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeHolder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cachType, url) in
                
                self.offerImageView.image = image
                
            })
            
        } else {
            
            self.messageTopCons.constant = 0
            self.offerImageHeightCons.constant = 0
            
        }
        
    }
    
}
