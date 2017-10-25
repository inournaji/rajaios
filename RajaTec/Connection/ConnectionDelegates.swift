//
//  ConnectionDelegates.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

protocol getHomeOffersConnectionDelegate {
    
    func getHomeOffersConnectionSuccess()
    func getHomeOffersConnectionFailure()
    
}

protocol getMobilesConnectionDelegate {
    
    func getMobilesConnectionSuccess()
    func getMobilesConnectionFailure()
    
}

protocol getAccessoriesConnectionDelegate {
    
    func getAccessoriesSuccess()
    func getAccessoriesFailure()
    
}