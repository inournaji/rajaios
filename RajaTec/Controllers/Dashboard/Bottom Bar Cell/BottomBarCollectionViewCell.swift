//
//  BottomBarCollectionViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 9/30/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class BottomBarCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isHighlighted: Bool {
        
        didSet {
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.titleLabel.alpha = self.isHighlighted ? 1 : 0.8
                
            }) { (finished) in
                
                UIView.animate(withDuration: 0.2) {
                    
                    self.titleLabel.alpha = self.isHighlighted ? 0.8 : 1
                    
                }
                
            }
            
        }
        
    }
    
    override var isSelected: Bool {
        
        didSet {
            
            UIView.animate(withDuration: 0.3) {
                
                self.backgroundColor = self.isSelected ? RajaColors.headerRedColor.getColor() : RajaColors.bottomBarColor.getColor()
                
                self.titleLabel.textColor = self.isSelected ? RajaColors.textWhiteColor.getColor() : RajaColors.headerRedColor.getColor()
                
            }
            
        }
        
    }

    func configure(title: String) {
        
        self.titleLabel.text = title
        
    }
    
}
