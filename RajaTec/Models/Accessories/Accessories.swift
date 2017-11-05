//
//  Accessories.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

class Accessories {
    
    static var existingAccessories: Bool {
        
        get {
            
            return Accessories.getAccessories().count > 0
            
        }
        
    }
    
    class func storeAccessories(accessories: [Accessory]) {
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: accessories)
        
        UserDefaults.standard.set(encodedData, forKey: CachingKeys.cacheAccessories.rawValue)
        
        UserDefaults.standard.synchronize()
        
    }
    
    class func getAccessories() -> [Accessory] {
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheAccessories.rawValue) as?  Data {
            
            let decodedOffers = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Accessory]
            
            return decodedOffers ?? [Accessory]()
            
        }
        
        return [Accessory]()
        
    }
    
    class func getAccessoriesAny() -> [Any] {
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheAccessories.rawValue) as?  Data {
            
            let decodedOffers = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Accessory]
            
            return decodedOffers ?? [Accessory]()
            
        }
        
        return [Accessory]()
        
    }
    
}
