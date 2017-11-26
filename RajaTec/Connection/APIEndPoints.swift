//
//  APIEndPoints.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

enum APIEndPoints: String {
    
    case rajaApi = "http://rajatec.net/en/api"
    case getHomeOffers = "/home"
    case getMobiles = "/mobile"
    case getMobileAccessories = "/mobile-accessories"
    case contactUs = "/node"
    case getBranches = "/branches-api"
    case warrantyActivate = "http://backoffice.rajatec.net/api/web/v1/waranties/activate"
    
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
         
        case .contactUs:
            return APIEndPoints.rajaApi.rawValue + self.rawValue
            
        case .warrantyActivate:
            return self.rawValue
            
        case .getBranches:
            return APIEndPoints.rajaApi.rawValue + self.rawValue
            
        }
        
    }
    
    static func getHeaders(token: String? = nil) -> [String: String] {
        
        if let _ = token {
            
            return ["Authorization" : "Basic YXBwdXNlcjpSam5vdUAyMDE3=", "Content-Type": "application/json"]
            
        }
        
        return ["Content-Type": "application/json"]
    }
    
    static func contactUsHeaders() -> [String : String] {
        
        let username = "appuser"
        let password = "Rjnou@2017"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["Authorization": "Basic \(base64LoginString)", "Content-Type": "application/x-www-form-urlencoded"]
        
        return headers
        
    }
    
    static func getWarrantyCheckParameters(IMEICode: String) -> String {
        
        return "field_imei_2_value=\(IMEICode)&field_device_imei_number_value=\(IMEICode)"
        
    }
    
}
