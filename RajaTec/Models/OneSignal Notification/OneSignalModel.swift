//
//  OneSignalModel.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/12/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import SwiftEventBus

class OneSignalModel {
    
    static func handleOneSignalNotification(userInfo: [AnyHashable : Any]) {
    
        print(userInfo)
        
        let offerObject = OfferNotification()
        
        if let aps = userInfo["aps"] as? NSDictionary {
            
            if let alert = aps["alert"] as? NSDictionary {
                
                if let message = alert["body"] as? String {
                    
                    offerObject.message = message
                    
                }
                
                if let title = alert["title"] as? String {
                    
                    offerObject.title = title
                    
                }
                
            }
            
        }
        
        if let att = userInfo["att"] as? NSDictionary {
            
            if let imageURL = att["id"] as? String {
                
                offerObject.imageUrl = imageURL
                
            }
            
        }
        
        NotificationOffers.storeOffers(offers: offerObject)
        
    }
    
    static func handleOneSignalNotificationWhenAppKilled(userInfo: [AnyHashable : Any]) {
        
        print(userInfo)
        
        let offerObject = OfferNotification()
        
        if let aps = userInfo["aps"] as? NSDictionary {
            
            if let alert = aps["alert"] as? NSDictionary {
                
                if let message = alert["body"] as? String {
                    
                    offerObject.message = message
                    
                }
                
                if let title = alert["title"] as? String {
                    
                    offerObject.title = title
                    
                }
                
            }
            
        }
        
        if let att = userInfo["att"] as? NSDictionary {
            
            if let imageURL = att["id"] as? String {
                
                offerObject.imageUrl = imageURL
                
            }
            
        }
        
        NotificationOffers.storeOffers(offers: offerObject)
        
        UserDefaults().set(true, forKey: "showNotificationAlert")
        
    }
    
    static func showAlertViewMessage() {
        
        if let topVC = UIApplication.topViewController() {
            
            let alertMessage = UIAlertController(title: NSLocalizedString("New Offer", comment: ""), message: NSLocalizedString("Do you want to check out the new Offer?", comment: ""), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (action) in
                
                SwiftEventBus.post(Events.goToOfferScreen.rawValue)
                
            })
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            
            alertMessage.addAction(okAction)
            
            alertMessage.addAction(cancelAction)
            
            topVC.present(alertMessage, animated: true, completion: nil)
            
        }
        
    }
    
}
