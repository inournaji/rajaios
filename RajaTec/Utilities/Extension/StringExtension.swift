//
//  StringExtension.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/17/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

extension String {
    
    var isPhoneNumber: Bool {
        
        let PHONE_REGEX = "(^[9][0-9]{8})"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        return phoneTest.evaluate(with: self)
        
    }
    
}
