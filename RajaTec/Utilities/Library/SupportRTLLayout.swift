//
//  SupportRTLLayout.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/17/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

class SupportRTLLayout {
    
    static let transform = CGAffineTransform(scaleX: -1, y: 1)
    
    class func transform(views viewArray: [UIView]) {
        
        if BundleLocalization.sharedInstance().language == "ar" {
            
            for viwe in viewArray {
                
                viwe.transform = transform
                
            }
            
        }
        
    }
    
}
