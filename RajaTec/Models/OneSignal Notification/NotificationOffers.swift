//
//  NotificationOffers.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/12/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import SwiftEventBus

class NotificationOffers {
    
    static var existingOffers: Bool {
        
        get {
            
            return NotificationOffers.getOffers().count > 0
            
        }
        
    }
    
    class func storeOffers(offers: OfferNotification) {
        
        var newOffers = [offers]
        
        newOffers.append(contentsOf: getOffers())
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: newOffers)
        
        UserDefaults.standard.set(encodedData, forKey: CachingKeys.cacheNotificationOffers.rawValue)
        
        UserDefaults.standard.synchronize()
        
        SwiftEventBus.post(Events.NewOfferRecieved.rawValue)
        
    }
    
    class func getOffers() -> [OfferNotification] {
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheNotificationOffers.rawValue) as?  Data {
            
            let decodedOffers = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [OfferNotification]
            
            return decodedOffers ?? [OfferNotification]()
            
        }
        
        return [OfferNotification]()
        
    }
    
}
