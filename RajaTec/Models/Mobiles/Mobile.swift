//
//  Mobile.swift
//
//  Created by Ammar  on 10/5/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Mobile: NSObject, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let battery = "Battery"
        static let screenSize = "Screen size"
        static let camera = "Camera"
        static let companyName = "Company"
        static let isOffer = "is_offer"
        static let storage = "Storage"
        static let nid = "nid"
        static let image = "Image"
        static let price = "Price"
        static let title = "title"
        static let processor = "Processor"
        static let ram = "Ram"
    }
    
    // MARK: Properties
    public var battery: String?
    public var screenSize: String?
    public var camera: String?
    public var companyName: String?
    public var isOffer: String?
    public var storage: String?
    public var nid: String?
    public var image: [String]?
    public var price: String?
    public var title: String?
    public var processor: String?
    public var ram: String?
    
    public override init() {
        
    }
    
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
        battery = json[SerializationKeys.battery].string
        screenSize = json[SerializationKeys.screenSize].string
        camera = json[SerializationKeys.camera].string
        companyName = json[SerializationKeys.companyName].string
        isOffer = json[SerializationKeys.isOffer].string
        storage = json[SerializationKeys.storage].string
        nid = json[SerializationKeys.nid].string
        if let items = json[SerializationKeys.image].array { image = items.map { $0.stringValue } }
        price = json[SerializationKeys.price].string
        title = json[SerializationKeys.title].string
        processor = json[SerializationKeys.processor].string
        ram = json[SerializationKeys.ram].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = battery { dictionary[SerializationKeys.battery] = value }
        if let value = screenSize { dictionary[SerializationKeys.screenSize] = value }
        if let value = camera { dictionary[SerializationKeys.camera] = value }
        if let value = companyName { dictionary[SerializationKeys.companyName] = value }
        if let value = isOffer { dictionary[SerializationKeys.isOffer] = value }
        if let value = storage { dictionary[SerializationKeys.storage] = value }
        if let value = nid { dictionary[SerializationKeys.nid] = value }
        if let value = image { dictionary[SerializationKeys.image] = value }
        if let value = price { dictionary[SerializationKeys.price] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = processor { dictionary[SerializationKeys.processor] = value }
        if let value = ram { dictionary[SerializationKeys.ram] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.battery = aDecoder.decodeObject(forKey: SerializationKeys.battery) as? String
        self.screenSize = aDecoder.decodeObject(forKey: SerializationKeys.screenSize) as? String
        self.camera = aDecoder.decodeObject(forKey: SerializationKeys.camera) as? String
        self.companyName = aDecoder.decodeObject(forKey: SerializationKeys.companyName) as? String
        self.isOffer = aDecoder.decodeObject(forKey: SerializationKeys.isOffer) as? String
        self.storage = aDecoder.decodeObject(forKey: SerializationKeys.storage) as? String
        self.nid = aDecoder.decodeObject(forKey: SerializationKeys.nid) as? String
        self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? [String]
        self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? String
        self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
        self.processor = aDecoder.decodeObject(forKey: SerializationKeys.processor) as? String
        self.ram = aDecoder.decodeObject(forKey: SerializationKeys.ram) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(battery, forKey: SerializationKeys.battery)
        aCoder.encode(screenSize, forKey: SerializationKeys.screenSize)
        aCoder.encode(camera, forKey: SerializationKeys.camera)
        aCoder.encode(companyName, forKey: SerializationKeys.companyName)
        aCoder.encode(isOffer, forKey: SerializationKeys.isOffer)
        aCoder.encode(storage, forKey: SerializationKeys.storage)
        aCoder.encode(nid, forKey: SerializationKeys.nid)
        aCoder.encode(image, forKey: SerializationKeys.image)
        aCoder.encode(price, forKey: SerializationKeys.price)
        aCoder.encode(title, forKey: SerializationKeys.title)
        aCoder.encode(processor, forKey: SerializationKeys.processor)
        aCoder.encode(ram, forKey: SerializationKeys.ram)
    }
    
    func getMobileDetailItem(index: Int) -> (mainTitle: String, value: String){
        
        if index == 0 {
            
            return (NSLocalizedString("Brand", comment: ""), self.companyName ?? "")
            
        } else if index == 1 {
            
            return (NSLocalizedString("Camera", comment: ""), self.camera ?? "")
            
        } else if index == 2 {
            
            return (NSLocalizedString("Screen", comment: ""), self.screenSize ?? "")
            
        } else if index == 3 {
            
            return (NSLocalizedString("Ram", comment: ""), self.ram ?? "")
            
        } else if index == 4 {
            
            return (NSLocalizedString("Storage", comment: ""), self.storage ?? "")
            
        } else if index == 5 {
            
            return (NSLocalizedString("Battery", comment: ""), self.battery ?? "")
            
        } else if index == 6 {
            
            return (NSLocalizedString("Price", comment: ""), self.price ?? "")
            
        } else if index == 7 {
            
            return (NSLocalizedString("Processor", comment: ""), self.processor ?? "")
            
        }
        
        return (NSLocalizedString("", comment: ""), "")
        
    }
    
}

