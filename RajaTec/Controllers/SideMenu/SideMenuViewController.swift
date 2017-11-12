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

protocol sideMenuExpandDelegate: class {
    
    func expandItemClicked(expandItem: ExpandItem)
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource, sideMenuExpandDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.menuItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuCell = self.menuTableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCellID", for: indexPath) as? SideMenuTableViewCell
        
        menuCell?.configure(menuItem: self.menuItems[indexPath.row], delegate: self)
        
        menuCell?.englishButton.addTarget(self, action: #selector(englishTapAction(_:)), for: .touchUpInside)
        
        menuCell?.arabicButton.addTarget(self, action: #selector(arabicTapAction(_:)), for: .touchUpInside)
        
        menuCell?.closeMenuButton.addTarget(self, action: #selector(closeSideMenu), for: .touchUpInside)
        
        return menuCell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.menuItems[indexPath.row] {
            
        case .gallary:
            
            if let cell = self.menuTableView.cellForRow(at: indexPath) as? SideMenuTableViewCell {
                
                self.menuTableView.beginUpdates()
                cell.expandCollapse()
                self.menuTableView.endUpdates()
                
            }
         
        case .home:
            
            if let revealMenu = self.revealViewController() {
                
                revealMenu.revealToggle(animated: true)
             
                revealMenu.setFront(HomeDashboardViewController.getInstance(with: .main), animated: true)
                
            }
            
        case .warranty:
            if let revealMenu = self.revealViewController() {
                
                revealMenu.revealToggle(animated: true)
                
                revealMenu.setFront(WarrantyCheckViewController.getInstance(), animated: true)
                
            }
            
        case .offers:
            
            if let revealMenu = self.revealViewController() {
                
                revealMenu.revealToggle(animated: true)
                
                revealMenu.setFront(OffersViewController.getInstance(), animated: true)
                
            }
            
            
        case .contactUS:
            if let revealMenu = self.revealViewController() {
                
                revealMenu.revealToggle(animated: true)
                
                revealMenu.setFront(ContactUsViewController.getInstance(), animated: true)
                
            }
            
        case .termsAndConditions:
            if let revealMenu = self.revealViewController() {
                
                revealMenu.revealToggle(animated: true)
                
                revealMenu.setFront(TermsConditionsViewController.getInstance(), animated: true)
                
            }
            
        case .joinUsonFacebook:
            
            let faceBookPage = "https://www.facebook.com/rajatecsyria/"
            
            if let faceBookPageUrl = URL(string: faceBookPage) {
                
                if UIApplication.shared.canOpenURL(faceBookPageUrl) {
                    
                    UIApplication.shared.open(faceBookPageUrl, options: [:], completionHandler: nil)
                    
                }
                
            }
            
            
        case .language:
            break
            
        case .close:
            break
        }
        
    }
    
    //MARK: - Actions
    @IBAction func englishTapAction(_ sender: Any) {
        
        if BundleLocalization.sharedInstance().language == "ar" {
        
            if let revealVC = self.revealViewController() {
                
               UserDefaults().set(1, forKey: "LanguageFlag")
               
               BundleLocalization.sharedInstance().language = "en"
                revealVC.navigationController?.pushViewController(SplashViewController.getInstance(changeLanguage: true), animated: true)
                
            }
            
        }
        
    }
    
    @IBAction func arabicTapAction(_ sender: Any) {
        
        if BundleLocalization.sharedInstance().language == "en" {
            
            if let revealVC = self.revealViewController() {
                
                UserDefaults().set(2, forKey: "LanguageFlag")
               
               BundleLocalization.sharedInstance().language = "ar"
                revealVC.navigationController?.pushViewController(SplashViewController.getInstance(changeLanguage: true), animated: true)
                
            }
            
        }
        
    }
    
    @objc func closeSideMenu() {
        
        if let revealMenu = self.revealViewController() {
            
            revealMenu.revealToggle(animated: true)
            
        }
        
    }
    
    func expandItemClicked(expandItem: ExpandItem) {
        
        self.menuTableView.beginUpdates()
        self.menuTableView.endUpdates()
        
        if let revealMenu = self.revealViewController() {
            
            revealMenu.revealToggle(animated: true)
            
        }
        
        switch expandItem {
            
        case .mobiles:
            self.revealViewController().setFront(HomeDashboardViewController.getInstance(with: .mobiles), animated: true)
            
        case .accessories:
            self.revealViewController().setFront(HomeDashboardViewController.getInstance(with: .accessories), animated: true)
            
        }
        
    }
    
}

