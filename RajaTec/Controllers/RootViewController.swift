//
//  RootViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation
import SwiftEventBus

class RootViewController: SWRevealViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftEventBus.onMainThread(self, name: Events.goToOfferScreen.rawValue) { (notification) in
            
            self.setFront(OffersViewController.getInstance(), animated: true)
            
        }
        
    }
    
}

