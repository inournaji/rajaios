//
//  APIEndPoints.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

enum APIEndPoints: String {
    
    case rajaApi = "http://rajatec.net/api"
    case getHomeOffers = "/home"
    case getMobiles = "/mobile"
    case getMobileAccessories = "/mobile-accessories"
    
    func getURL() -> String {
        
        switch self {
            
        case .rajaApi:
            return self.rawValue
            
        case .getHomeOffers:
            return APIEndPoints.rajaApi.rawValue + self.rawValue
            
        case .getMobiles:
            return APIEndPoints.rajaApi.rawValue + self.rawValue
            
        case .getMobileAccessories:
            return APIEndPoints.rajaApi.rawValue + self.rawValue
         
        }
        
    }
    
    static func getHeaders(token: String? = nil) -> [String: String] {
        
        if let _ = token {
            
            return ["Authorization" : "Basic c3VwZXJoZXJvOmNoYW5nZU1lIVNEUlRIR0pHSEdGRFNGR2g=", "Content-Type": "application/json"]
            
        }
        
        return ["Content-Type": "application/json"]
    }
    
}
