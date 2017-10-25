//
//  Accessory.swift
//
//  Created by Ammar Arangy on 10/5/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Accessory: NSObject, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let image = "Image"
    static let nid = "nid"
    static let title = "title"
    static let mobile = "Mobile"
    static let price = "Price"
    static let accessoryType = "Accessory type"
  }

  // MARK: Properties
  public var image: String?
  public var nid: String?
  public var title: String?
  public var mobile: [String]?
  public var price: String?
  public var accessoryType: String?

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
    image = json[SerializationKeys.image].string
    nid = json[SerializationKeys.nid].string
    title = json[SerializationKeys.title].string
    if let items = json[SerializationKeys.mobile].array { mobile = items.map { $0.stringValue } }
    price = json[SerializationKeys.price].string
    accessoryType = json[SerializationKeys.accessoryType].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = nid { dictionary[SerializationKeys.nid] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = mobile { dictionary[SerializationKeys.mobile] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    if let value = accessoryType { dictionary[SerializationKeys.accessoryType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.nid = aDecoder.decodeObject(forKey: SerializationKeys.nid) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.mobile = aDecoder.decodeObject(forKey: SerializationKeys.mobile) as? [String]
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? String
    self.accessoryType = aDecoder.decodeObject(forKey: SerializationKeys.accessoryType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(nid, forKey: SerializationKeys.nid)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(mobile, forKey: SerializationKeys.mobile)
    aCoder.encode(price, forKey: SerializationKeys.price)
    aCoder.encode(accessoryType, forKey: SerializationKeys.accessoryType)
  }

}
