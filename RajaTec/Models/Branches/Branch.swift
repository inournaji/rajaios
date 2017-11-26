//
//  Branch.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/24/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

public final class Branch: NSObject, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let longe = "longe"
        static let title = "title"
        static let phoneNumber = "Phone number"
        static let lat = "lat"
        static let address = "Address"
        static let nid = "nid"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    // MARK: Properties
    public var longe: String?
    public var title: String?
    public var phoneNumber: String?
    public var lat: String?
    public var address: String?
    public var nid: String?
    
    func getLatitude() ->  Double? {
        
        if let lat = self.lat {
            
            return Double(lat) ?? nil
            
        } else {
            
            return nil
            
        }
        
    }
    
    func getLongitude() -> Double? {
        
        if let long = self.longe {
            
            return Double(long) ?? nil
            
        } else {
            
            return nil
            
        }
        
    }
    
    override init() {}
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        longe = json[SerializationKeys.longe].string
        title = json[SerializationKeys.title].string
        phoneNumber = json[SerializationKeys.phoneNumber].string
        lat = json[SerializationKeys.lat].string
        address = json[SerializationKeys.address].string
        nid = json[SerializationKeys.nid].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = longe { dictionary[SerializationKeys.longe] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = phoneNumber { dictionary[SerializationKeys.phoneNumber] = value }
        if let value = lat { dictionary[SerializationKeys.lat] = value }
        if let value = address { dictionary[SerializationKeys.address] = value }
        if let value = nid { dictionary[SerializationKeys.nid] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.longe = aDecoder.decodeObject(forKey: SerializationKeys.longe) as? String
        self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
        self.phoneNumber = aDecoder.decodeObject(forKey: SerializationKeys.phoneNumber) as? String
        self.lat = aDecoder.decodeObject(forKey: SerializationKeys.lat) as? String
        self.address = aDecoder.decodeObject(forKey: SerializationKeys.address) as? String
        self.nid = aDecoder.decodeObject(forKey: SerializationKeys.nid) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(longe, forKey: SerializationKeys.longe)
        aCoder.encode(title, forKey: SerializationKeys.title)
        aCoder.encode(phoneNumber, forKey: SerializationKeys.phoneNumber)
        aCoder.encode(lat, forKey: SerializationKeys.lat)
        aCoder.encode(address, forKey: SerializationKeys.address)
        aCoder.encode(nid, forKey: SerializationKeys.nid)
    }
    
}

