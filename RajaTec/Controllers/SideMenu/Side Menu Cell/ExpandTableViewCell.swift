//
//  ExpandTableViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/1/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class ExpandTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var expandTitle: UILabel!
    @IBOutlet weak var selecetButon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(expandItem: ExpandItem) {
        
        self.expandTitle.text = expandItem.getTitle()
        
    }
    
}
