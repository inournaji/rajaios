//
//  Branches.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/24/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

class Branches {
    
    static var existingBranches: Bool {
        
        get {
            
            return Branches.getBranches().count > 0
            
        }
        
    }
    
    class func storeBranches(branches: [Branch]) {
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: branches)
        
        UserDefaults.standard.set(encodedData, forKey: CachingKeys.cacheBranches.rawValue)
        
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: CachingKeys.lastPullToRefreshDate.rawValue)
        
        UserDefaults.standard.synchronize()
        
    }
    
    class func getBranches() -> [Branch] {
        
        if let decodedData = UserDefaults.standard.object(forKey: CachingKeys.cacheBranches.rawValue) as?  Data {
            
            let decodedBranches = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Branch]
            
            return decodedBranches ?? [Branch]()
            
        }
        
        return [Branch]()
        
    }
    
}

