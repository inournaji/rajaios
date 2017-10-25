//
//  Connection.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Connection {
    
    //MARK: - get home offers
    class func getHomeOffers(delegate: getHomeOffersConnectionDelegate? = nil) {
        
        let getHomeURL = APIEndPoints.getHomeOffers.getURL()
        
        Alamofire.request(getHomeURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
                
            case .failure:
                
                print("Couldn't get offers articles")
                
                delegate?.getHomeOffersConnectionFailure()
                
            case .success(let anyobjectResponse):
                
                let parsedJson = JSON(anyobjectResponse)
                
                guard parsedJson.arrayValue.count > 0  else {
                    
                    delegate?.getHomeOffersConnectionFailure()
                    
                    return
                    
                }
                
                var offers = [Offer]()
                
                for offerJson in parsedJson.arrayValue {
                    
                    offers.append(Offer(json: offerJson))
                    
                }
                
                Offers.storeOffers(offers: offers)
                
                delegate?.getHomeOffersConnectionSuccess()
                
            }
            
        })
        
    }
    
    //MARK: - get Mobiles
    class func getMobiles(delegate: getMobilesConnectionDelegate? = nil) {
        
        let getHomeURL = APIEndPoints.getMobiles.getURL()
        
        Alamofire.request(getHomeURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
                
            case .failure:
                
                print("Couldn't get mobiles articles")
                
                delegate?.getMobilesConnectionFailure()
                
            case .success(let anyobjectResponse):
                
                let parsedJson = JSON(anyobjectResponse)
                
                guard parsedJson.arrayValue.count > 0  else {
                    
                    delegate?.getMobilesConnectionFailure()
                    
                    return
                    
                }
                
                var mobiles = [Mobile]()
                
                for mobileJson in parsedJson.arrayValue {
                    
                    mobiles.append(Mobile(json: mobileJson))
                    
                }
                
                Mobiles.storeMobiles(mobiles: mobiles)
                
                delegate?.getMobilesConnectionSuccess()
                
            }
            
        })
        
    }
    
    //MARK: - get Mobiles
    class func getAccessories(delegate: getAccessoriesConnectionDelegate? = nil) {
        
        let getAccessoryURL = APIEndPoints.getMobileAccessories.getURL()
        
        Alamofire.request(getAccessoryURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
                
            case .failure:
                
                print("Couldn't get mobiles articles")
                
                delegate?.getAccessoriesFailure()
                
            case .success(let anyobjectResponse):
                
                let parsedJson = JSON(anyobjectResponse)
                
                guard parsedJson.arrayValue.count > 0  else {
                    
                    delegate?.getAccessoriesFailure()
                    
                    return
                    
                }
                
                var accessories = [Accessory]()
                
                for accessoryJson in parsedJson.arrayValue {
                    
                    accessories.append(Accessory(json: accessoryJson))
                    
                }
                
                Accessories.storeAccessories(accessories: accessories)
                
                delegate?.getAccessoriesSuccess()
            }
            
        })
        
    }
    
}


