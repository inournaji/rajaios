//
//  SideMenuViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

enum MenuItem {
    
    case close
    case home
    case gallary
    case warranty
    case offers
    case contactUS
    case termsAndConditions
    case joinUsonFacebook
    case language
    
    static func getMenuItems() -> [MenuItem] {
        
        return [.close, .home, .gallary, .warranty, .offers, .contactUS, .termsAndConditions, .joinUsonFacebook, .language]
        
    }
    
    func getIcon() -> UIImage {
        
        switch self {
            
        case .close:
            return #imageLiteral(resourceName: "close-icon")
            
        case .home:
            return #imageLiteral(resourceName: "home-icon")
            
        case .gallary:
            return #imageLiteral(resourceName: "gallary-icon")
            
        case .warranty:
            return #imageLiteral(resourceName: "warranty-icon")
            
        case .offers:
            return #imageLiteral(resourceName: "offers-icon")
            
        case .contactUS:
            return #imageLiteral(resourceName: "contact-us-icon")
            
        case .termsAndConditions:
            return #imageLiteral(resourceName: "terms-condition-icon")
            
        case .joinUsonFacebook:
            return #imageLiteral(resourceName: "facebook-icon")
            
        case .language:
            return UIImage()
            
        }
        
    }
    
    func getTitle() -> String {
        
        switch self {
            
        case .close:
            return ""
            
        case .home:
            return NSLocalizedString("Home", comment: "")
            
        case .gallary:
            return NSLocalizedString("Gallary", comment: "")
        case .warranty:
            return NSLocalizedString("Warranty", comment: "")
            
        case .offers:
            return NSLocalizedString("Offers", comment: "")
            
        case .contactUS:
            return NSLocalizedString("Contact Us", comment: "")
            
        case .termsAndConditions:
            return NSLocalizedString("Terms and Conditions", comment: "")
            
        case .joinUsonFacebook:
            return NSLocalizedString("Join us on Facebook", comment: "")
            
        case .language:
            return ""
            
        }
        
    }
    
    func getExpandOptions() -> [ExpandItem] {
        
        switch self {
            
        case .close,.home,.contactUS,.joinUsonFacebook,.language,.termsAndConditions,.offers,.warranty:
            return [ExpandItem]()
            
        case .gallary:
            return [.accessories, .mobiles]
            
        }
        
    }
    
}

enum ExpandItem {
    case mobiles
    case accessories
    
    func getTitle() -> String {
        
        switch self {
            
        case .mobiles:
            return NSLocalizedString("mobiles", comment: "")
            
        case .accessories:
            return NSLocalizedString("accessories", comment: "")
            
            
        }
        
    }
    
}

class SideMenuViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var menuTableView: UITableView!
    
    //MARK: - Variables
    var menuItems = MenuItem.getMenuItems()
    var homeExpandHeigt: CGFloat = 58
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.delegate = self
        
        self.menuTableView.dataSource = self
        
        self.menuTableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCellID")
        
        self.menuTableView.estimatedRowHeight = 70
        
        self.menuTableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.menuItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuCell = self.menuTableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCellID", for: indexPath) as? SideMenuTableViewCell
        
        menuCell?.configure(menuItem: self.menuItems[indexPath.row])
        
        menuCell?.closeMenuButton.addTarget(self, action: #selector(closeSideMenu), for: .touchUpInside)
        
        return menuCell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.menuItems[indexPath.row] == .gallary {
            
            if let cell = self.menuTableView.cellForRow(at: indexPath) as? SideMenuTableViewCell {
                
                self.menuTableView.beginUpdates()
                cell.expandCollapse()
                self.menuTableView.endUpdates()
                
            }
            
        }
    }
    
    @objc func closeSideMenu() {
        
        if let revealMenu = self.revealViewController() {
            
            revealMenu.revealToggle(animated: true)
            
        }
        
    }
    
}

