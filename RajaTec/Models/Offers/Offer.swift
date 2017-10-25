//
//  Offer.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Offer: NSObject, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let title = "Title"
        static let image = "Image"
        static let link = "Link"
        static let fixedWidth = "fixed_width"
        static let video = "Video"
    }
    
    // MARK: Properties
    public var title: String?
    public var image: String?
    public var link: String?
    public var fixedWidth: String?
    public var video: String?
    
    
    
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
        image = json[SerializationKeys.image].string
        link = json[SerializationKeys.link].string
        fixedWidth = json[SerializationKeys.fixedWidth].string
        video = json[SerializationKeys.video].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = image { dictionary[SerializationKeys.image] = value }
        if let value = link { dictionary[SerializationKeys.link] = value }
        if let value = fixedWidth { dictionary[SerializationKeys.fixedWidth] = value }
        if let value = video { dictionary[SerializationKeys.video] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
        self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
        self.link = aDecoder.decodeObject(forKey: SerializationKeys.link) as? String
        self.fixedWidth = aDecoder.decodeObject(forKey: SerializationKeys.fixedWidth) as? String
        self.video = aDecoder.decodeObject(forKey: SerializationKeys.video) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: SerializationKeys.title)
        aCoder.encode(image, forKey: SerializationKeys.image)
        aCoder.encode(link, forKey: SerializationKeys.link)
        aCoder.encode(fixedWidth, forKey: SerializationKeys.fixedWidth)
        aCoder.encode(video, forKey: SerializationKeys.video)
    }
    
}
