//
//  Offer.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/12/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import SwiftyJSON

public class OfferNotification: NSObject, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let title = "title"
        static let message = "message"
        static let imageUrl = "imageUrl"
        static let offerDate = "offerDate"
    }
    
    // MARK: Properties
    public var title: String?
    public var message: String?
    public var imageUrl: String?
    public var offerDate: Date?
    
    var image: URL? {
        
        get {
            
            if let imageString = imageUrl {
                
                return URL(string: imageString) ?? nil
                
            }
            
            return nil
            
        }
        
    }
    
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
        title = json[SerializationKeys.title].string
        message = json[SerializationKeys.message].string
        imageUrl = json[SerializationKeys.imageUrl].string
        
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = message { dictionary[SerializationKeys.message] = value }
        if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
        if let value = offerDate { dictionary[SerializationKeys.offerDate] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
        self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
        self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
        self.offerDate = aDecoder.decodeObject(forKey: SerializationKeys.offerDate) as? Date
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: SerializationKeys.title)
        aCoder.encode(message, forKey: SerializationKeys.message)
        aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
        aCoder.encode(offerDate, forKey: SerializationKeys.offerDate)
    }
    
}
