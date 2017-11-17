//
//  Warranty.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/17/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON

public class Warranty: NSObject, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let error = "error"
        static let id = "id"
        static let imei1 = "imei1"
        static let imei2 = "imei2"
        static let sell_date = "sell_date"
        static let start_date = "start_date"
        static let end_date = "end_date"
        static let status = "status"
        static let notes = "notes"
        static let mobile = "mobile"
        static let model = "model"
    }
    
    // MARK: Properties
    public var error: String?
    public var id: Int?
    public var imei1: String?
    public var imei2: String?
    public var sell_date: String?
    public var start_date: String?
    public var end_date: String?
    public var status: String?
    public var notes: String?
    public var mobile: String?
    public var model: String?
    
    override public init() {}
    
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
        
        id = json[SerializationKeys.id].int
        imei1 = json[SerializationKeys.imei1].string
        imei2 = json[SerializationKeys.imei2].string
        sell_date = json[SerializationKeys.sell_date].string
        start_date = json[SerializationKeys.start_date].string
        end_date = json[SerializationKeys.end_date].string
        status = json[SerializationKeys.status].string
        notes = json[SerializationKeys.notes].string
        mobile = json[SerializationKeys.mobile].string
        model = json[SerializationKeys.model].string
        error = json[SerializationKeys.error].string
        
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = imei1 { dictionary[SerializationKeys.imei1] = value }
        if let value = imei2 { dictionary[SerializationKeys.imei2] = value }
        if let value = sell_date { dictionary[SerializationKeys.sell_date] = value }
        if let value = start_date { dictionary[SerializationKeys.start_date] = value }
        if let value = end_date { dictionary[SerializationKeys.end_date] = value }
        if let value = status { dictionary[SerializationKeys.status] = value }
        if let value = notes { dictionary[SerializationKeys.notes] = value }
        if let value = mobile { dictionary[SerializationKeys.mobile] = value }
        if let value = model { dictionary[SerializationKeys.model] = value }
        if let value = error { dictionary[SerializationKeys.error] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.imei1 = aDecoder.decodeObject(forKey: SerializationKeys.imei1) as? String
        self.imei2 = aDecoder.decodeObject(forKey: SerializationKeys.imei2) as? String
        self.sell_date = aDecoder.decodeObject(forKey: SerializationKeys.sell_date) as? String
        self.start_date = aDecoder.decodeObject(forKey: SerializationKeys.start_date) as? String
        self.end_date = aDecoder.decodeObject(forKey: SerializationKeys.end_date) as? String
        self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
        self.notes = aDecoder.decodeObject(forKey: SerializationKeys.notes) as? String
        self.mobile = aDecoder.decodeObject(forKey: SerializationKeys.mobile) as? String
        self.model = aDecoder.decodeObject(forKey: SerializationKeys.model) as? String
        self.error = aDecoder.decodeObject(forKey: SerializationKeys.error) as? String
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(imei1, forKey: SerializationKeys.imei1)
        aCoder.encode(imei2, forKey: SerializationKeys.imei2)
        aCoder.encode(sell_date, forKey: SerializationKeys.sell_date)
        aCoder.encode(start_date, forKey: SerializationKeys.start_date)
        aCoder.encode(end_date, forKey: SerializationKeys.end_date)
        aCoder.encode(status, forKey: SerializationKeys.status)
        aCoder.encode(notes, forKey: SerializationKeys.notes)
        aCoder.encode(mobile, forKey: SerializationKeys.mobile)
        aCoder.encode(model, forKey: SerializationKeys.model)
        aCoder.encode(error, forKey: SerializationKeys.error)
    }
    
}
