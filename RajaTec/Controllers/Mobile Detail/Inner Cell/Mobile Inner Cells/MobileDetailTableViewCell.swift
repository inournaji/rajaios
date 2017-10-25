//
//  MobileDetailTableViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/10/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class MobileDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailMainLabel: UILabel!
    @IBOutlet weak var detailValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with mainItem: String, value: String) {
        
        self.detailMainLabel.text = mainItem
        self.detailValueLabel.text = value
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

