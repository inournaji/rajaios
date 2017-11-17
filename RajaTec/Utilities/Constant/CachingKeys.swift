//
//  CachingKeys.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

//MARK: - Caching Enum
enum CachingKeys:  String {
    
    case cacheOffers = "cacheOffers"
    case cacheMobiles = "cacheMobiles"
    case cacheAccessories = "cacheAccessories"
    case cacheNotificationOffers = "cacheNotificationOffers"
    case cacheWarranty = "cacheWarranty"
    case lastPullToRefreshDate = "lastPullToRefreshDate"
}
