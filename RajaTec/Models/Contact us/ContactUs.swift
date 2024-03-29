//
//  ContactUs.swift
//
//  Created by Ammar Arangy on 11/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ContactUs {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let uri = "uri"
    static let nid = "nid"
  }

  // MARK: Properties
  public var uri: String?
  public var nid: String?

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
    uri = json[SerializationKeys.uri].string
    nid = json[SerializationKeys.nid].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    if let value = nid { dictionary[SerializationKeys.nid] = value }
    return dictionary
  }

}
