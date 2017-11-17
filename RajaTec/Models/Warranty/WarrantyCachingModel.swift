//
//  WarrantyCachingModel.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/17/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

class WarrantyCachingModel {
    
    static var existingWarranty: Bool {
        
        get {
            
            return WarrantyCachingModel.getWarranty() != nil ? true : false
            
        }
        
    }
    
    class func storeWarranty(warranty: Warranty) {
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: warranty)
        
        UserDefaults.standard.set(encodedData, forKey: CachingKeys.cacheWarranty.rawValue)
        
        UserDefaults.standard.synchronize()
        
    }
    
    class func getWarranty() -> Warranty? {
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheWarranty.rawValue) as?  Data {
            
            let decodedWarranty = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? Warranty
            
            return decodedWarranty
            
        }
        
        return nil
        
    }
    
}
