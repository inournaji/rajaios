//
//  Mobiles.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

class Mobiles {
    
    static var existingMobiles: Bool {
        
        get {
            
            return Mobiles.getMobiles().count > 0
            
        }
        
    }
    
    class func storeMobiles(mobiles: [Mobile]) {
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: mobiles)
        
        UserDefaults.standard.set(encodedData, forKey: CachingKeys.cacheMobiles.rawValue)
        
        UserDefaults.standard.synchronize()
        
    }
    
    class func getMobiles() -> [Mobile] {
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheMobiles.rawValue) as?  Data {
            
            let decodedOffers = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Mobile]
            
            return decodedOffers ?? [Mobile]()
            
        }
        
        return [Mobile]()
        
    }
    
    class func getMobiles(with keyWord: String) -> [Any] {
        
        var searchMobile = [Mobile]()
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheMobiles.rawValue) as?  Data {
            
            if let decodedMobiles = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Mobile] {
                
                for mobile in decodedMobiles {
                    
                    if let title = mobile.title, title.lowercased().contains(keyWord.lowercased()) {
                        
                        searchMobile.append(mobile)
                        
                    }
                    
                }
                
            }
            
        }
        
        return searchMobile
        
    }
    
}
