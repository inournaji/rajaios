//
//  UIViewExtension.swift
//  RajaTec
//
//  Created by Ammar Arangy on 9/30/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor : UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
}
