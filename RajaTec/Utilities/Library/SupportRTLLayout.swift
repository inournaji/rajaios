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
    
    class func transform(superView parentView: UIView) {
        
        if BundleLocalization.sharedInstance().language == "ar" {
            
            for viwe in parentView.subviews {
                
                if viwe.subviews.count > 1 {
                    
                    transform(superView: viwe)
                    
                } else {
                    
                    viwe.transform = transform
                    
                }
                
            }
            
        }
        
    }
    
    class func rightTextAlighment(superView parentView: UIView) {
        
        if BundleLocalization.sharedInstance().language == "ar" {
            
            for viwe in parentView.subviews {
                
                if viwe.subviews.count > 1 {
                    
                    rightTextAlighment(superView: viwe)
                    
                } else {
                    
                    if let label = viwe as? UILabel {
                        
                        label.textAlignment = .right
                        
                    } else if let textField = viwe as? UITextField {
                        
                        textField.textAlignment = .right
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
