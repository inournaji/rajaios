//
//  RootViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation


class RootViewController: SWRevealViewController {
    
    //MARK: - Variables
    var homeDashboardViewController: HomeDashboardViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeSlideOutMenu()
        
    }
    
    func customizeSlideOutMenu() {
        // INITIAL APPEARANCE: Configure the initial position of the menu and content views
        self.frontViewPosition = FrontViewPosition.left //FrontViewPositionLeft FrontViewPositionLeft (only content), FrontViewPositionRight(menu and content), FrontViewPositionRightMost(only menu), see others at library documentation...
        self.rearViewRevealWidth = UIScreen.main.bounds.width * 0.778//150.0 // how much of the menu is shown (default 260.0)
        
        // TOGGLING OVERDRAW: Configure the overdraw appearance of the content view while dragging it
        //This parameter (rearViewRevealOverdraw) is one who is responsible for making over toggle to the right animation,
        self.rearViewRevealOverdraw = 0.0 // how much of an overdraw can occur when dragging further than 'rearViewRevealWidth' (default 60.0)
        self.bounceBackOnOverdraw = false // If YES the controller will bounce to the Left position when dragging further than 'rearViewRevealWidth' (default YES)
        self.bounceBackOnLeftOverdraw = false
        self.rightViewRevealOverdraw = 0.0
        
        // TOGGLING MENU DISPLACEMENT: how much displacement is applied to the menu when animating or dragging the content
        self.rearViewRevealDisplacement = 60.0 // (default 40.0)
        
        // TOGGLING ANIMATION: Configure the animation while the menu gets hidden
        self.toggleAnimationType = SWRevealToggleAnimationType.spring // Animation type (SWRevealToggleAnimationTypeEaseOut or SWRevealToggleAnimationTypeSpring)
        self.toggleAnimationDuration = 0.4//1.0 // Duration for the revealToggle animation (default 0.25)
        
        self.springDampingRatio = 1.0 // damping ratio if SWRevealToggleAnimationTypeSpring (default 1.0)
        
        // SHADOW: Configure the shadow that appears between the menu and content views
        self.frontViewShadowRadius = 0 // radius of the front view's shadow (default 2.5)
        self.frontViewShadowOffset = CGSize(width: 0, height: 0) // radius of the front view's shadow offset (default {0.0f,2.5f})
        self.frontViewShadowOpacity = 0.8 // front view's shadow opacity (default 1.0)
        self.frontViewShadowColor = UIColor.clear // front view's shadow color (default blackColor)
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        print(identifier)
        
    }
    
}

