//
//  UIImageExtension.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

extension UIImageView {
    
    func changeImageTintColor(_ color: UIColor) {
        
        self.image = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        self.tintColor = color
        
    }
    
}
