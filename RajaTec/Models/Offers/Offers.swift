//
//  Offers.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

class Offers {
    
    static var existingOffers: Bool {
    
        get {
    
            return Offers.getOffers().count > 0 
            
        }
        
    }
    
    class func storeOffers(offers: [Offer]) {
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: offers)
        
        UserDefaults.standard.set(encodedData, forKey: CachingKeys.cacheOffers.rawValue)
        
        UserDefaults.standard.synchronize()
        
    }
    
    class func getOffers() -> [Offer] {
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheOffers.rawValue) as?  Data {
            
            let decodedOffers = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Offer]
            
            return decodedOffers ?? [Offer]()
            
        }
        
        return [Offer]()
        
    }
}
