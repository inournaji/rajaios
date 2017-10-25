//
//  RajaColours.swift
//  RajaTec
//
//  Created by Ammar Arangy on 9/30/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import UIKit

enum RajaColors {
    
    case headerRedColor
    case headerBlackColor
    case textWhiteColor
    case bottomBarColor
    
    func getColor() -> UIColor {
        
        switch self {
        case .headerRedColor:
            return UIColor(red: 228/255, green: 27/255, blue: 35/255, alpha: 1)
            
        case .headerBlackColor:
            return UIColor.black
            
        case .textWhiteColor:
            return UIColor.white
        
        case .bottomBarColor:
            return UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
            
        }
        
    }
    
}
