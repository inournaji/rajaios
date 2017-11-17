//
//  ItemsListViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

enum ListType {
    case Home
    case mobile
    case accessories
    
    func getCellSize() -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        switch self {
            
        case .Home:
            
            let homeWidth = screenWidth
            
            let homeHeight = screenWidth * 1.1
            
            return CGSize(width: homeWidth, height: homeHeight)
            
        case .mobile, .accessories:
            
            let homeWidth = screenWidth / 2 - 20
            
            let homeHeight = homeWidth * 1.4
            
            return CGSize(width: homeWidth, height: homeHeight)
            
        }
        
    }
    
}

protocol ItemsListViewControllerDelegate: class {
    
    func userDidSelectMobile(selectedMobile: Mobile)
    
}

class ItemsListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var itemListCollectionView: UICollectionView!
    @IBOutlet weak var noResultLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIView!
    
    //MARK: - Variables
    var homeDataSource = [Offer]()
    var mobileDataSource = [Mobile]()
    var accessoriesDataSource = [Accessory]()
    var itemListType = ListType.Home
    var connectionActivityIndicator: NVActivityIndicatorView?
    let refreshControl = UIRefreshControl()
    
    //MARK: - Delegates
    weak var itemsListViewControllerDelegate: ItemsListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congifureActivityIndicatorView()
        
        switch itemListType {
        case .Home:
            self.getHomeOffers()
            
        case .mobile:
            self.getMobiles()
            
        case .accessories:
            self.getAccessories()
            
        }
                
        self.itemListCollectionView.delegate = self
        
        self.itemListCollectionView.dataSource = self
        
        self.itemListCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCellID")
        
        self.itemListCollectionView.register(UINib(nibName: "MobileAccessoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MobileAccessoriesCollectionViewCellID")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.configurePullToRefresh()
        
    }
    
    func configurePullToRefresh() {
        
        self.updatePulltorefreshTitle()
        
        refreshControl.tintColor = RajaColors.headerRedColor.getColor()
        
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction(sender:)), for: .valueChanged)
        
        self.itemListCollectionView.addSubview(refreshControl)
        
        self.itemListCollectionView.sendSubview(toBack: refreshControl)
        
        self.refreshControl.layer.zPosition = -1
        
        self.itemListCollectionView.alwaysBounceVertical = true
        
    }
    
    func updatePulltorefreshTitle() {
        
        let lastPullToRefreshTimeInterval = UserDefaults.standard.double(forKey: CachingKeys.lastPullToRefreshDate.rawValue)
        
        if lastPullToRefreshTimeInterval > 0 {
            
            let lastDate = Date(timeIntervalSince1970: lastPullToRefreshTimeInterval)
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            
            let dateString =  "\(NSLocalizedString("Last pull to refresh", comment: "")): \(dateFormatter.string(from: lastDate))"
            
            refreshControl.attributedTitle = NSAttributedString(string: dateString)
            
        } else {
            
            refreshControl.attributedTitle = NSAttributedString(string: "")
            
        }
                
    }
    
    func congifureActivityIndicatorView() {
        
        let activityFrame = CGRect(x: 0, y: 0, width: activityIndicatorView.frame.width, height: activityIndicatorView.frame.height)
        
        connectionActivityIndicator = NVActivityIndicatorView(frame: activityFrame, type: .ballGridPulse, color: RajaColors.headerRedColor.getColor(), padding: nil)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        activityIndicatorView.addSubview(connectionActivityIndicator!)
        
    }
    
    func getHomeOffers() {
        
        if Offers.existingOffers {
            
            self.homeDataSource = Offers.getOffers()
            
            self.handleActivityIndicator(animate: false)
            
        } else {
            
            self.handleActivityIndicator(animate: true)
            
            Connection.getHomeOffers(delegate: self)
            
        }
        
    }
    
    func getMobiles() {
        
        if Mobiles.existingMobiles {
            
            self.mobileDataSource = Mobiles.getMobiles()
            
            self.handleActivityIndicator(animate: false)
            
        } else {
            
            self.handleActivityIndicator(animate: true)
            
            Connection.getMobiles(delegate: self)
            
        }
        
    }
    
    func getAccessories() {
        
        if Accessories.existingAccessories {
            
            self.accessoriesDataSource = Accessories.getAccessories()
            
            self.handleActivityIndicator(animate: false)
            
        } else {
            
            self.handleActivityIndicator(animate: true)
            
            Connection.getAccessories(delegate: self)
            
        }
        
    }
    
    @objc func pullToRefreshAction(sender: UIRefreshControl) {
        
        switch self.itemListType {
        case .Home:
            Connection.getHomeOffers(delegate: self)
            
        case .mobile:
            Connection.getMobiles(delegate: self)
            
        case .accessories:
            Connection.getAccessories(delegate: self)
            
        }
        
    }

    @IBAction func retryAction(_ sender: Any) {
        
        self.handleActivityIndicator(animate: true)
        
        switch self.itemListType {
        case .Home:
            Connection.getHomeOffers(delegate: self)
            
        case .mobile:
            Connection.getMobiles(delegate: self)
            
        case .accessories:
            Connection.getAccessories(delegate: self)
            
        }
        
    }
    
    func handleActivityIndicator(animate: Bool) {
        
        self.activityIndicatorView.isHidden = !animate
        
        if  animate {
            
            self.connectionActivityIndicator?.startAnimating()
            
            self.noResultLabel.isHidden = true
            
        } else {
            
            self.connectionActivityIndicator?.stopAnimating()
            
            switch itemListType {
            case .Home:
                self.noResultLabel.isHidden = self.homeDataSource.count != 0
                
            case .mobile:
                self.noResultLabel.isHidden = self.mobileDataSource.count != 0
                
            case .accessories:
                self.noResultLabel.isHidden = self.accessoriesDataSource.count != 0
                
            }
            
        }
        
    }
    
    func changeListType(listType: ListType) {
        
        self.itemListType = listType
        
        switch self.itemListType {
        case .Home:
            self.getHomeOffers()
            
        case .mobile:
            self.getMobiles()
            
        case .accessories:
            self.getAccessories()
            
        }
        
        self.itemListCollectionView.reloadData()
        
    }
    
}

extension ItemsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch self.itemListType {
        case .Home:
            return self.homeDataSource.count
            
        case .mobile:
            return self.mobileDataSource.count
            
        case .accessories:
            return self.accessoriesDataSource.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.itemListType {
        case .Home:
            
            let homeCell = self.itemListCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCellID", for: indexPath) as? HomeCollectionViewCell
            
            homeCell?.configureCell(offer: self.homeDataSource[indexPath.item])
            
            return homeCell!
            
        case .mobile:
            
            let mobileCell = self.itemListCollectionView.dequeueReusableCell(withReuseIdentifier: "MobileAccessoriesCollectionViewCellID", for: indexPath) as? MobileAccessoriesCollectionViewCell
            
            mobileCell?.configureCell(mobile: self.mobileDataSource[indexPath.item])
            
            return mobileCell!
            
        case .accessories:
            
            let mobileCell = self.itemListCollectionView.dequeueReusableCell(withReuseIdentifier: "MobileAccessoriesCollectionViewCellID", for: indexPath) as? MobileAccessoriesCollectionViewCell
            
            mobileCell?.configureCell(accessoryItem: self.accessoriesDataSource[indexPath.item])
            
            return mobileCell!
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.itemListType.getCellSize()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.itemListType {
        case .Home:
            
            let homeOffer = self.homeDataSource[indexPath.item]
            
            if let link = homeOffer.link, let url = URL(string: link) {
                
                if UIApplication.shared.canOpenURL(url) {
                 
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
                }
                
            }
            
        case .mobile:
            
            let mobileItem = self.mobileDataSource[indexPath.item]
            
            self.itemsListViewControllerDelegate?.userDidSelectMobile(selectedMobile: mobileItem)
                        
        case .accessories:
                break
            
        }
        
    }
    
}

extension ItemsListViewController : getHomeOffersConnectionDelegate {
    
    func getHomeOffersConnectionSuccess() {
        
        self.handleActivityIndicator(animate: false)
        
        self.homeDataSource = Offers.getOffers()
        
        if self.refreshControl.isRefreshing {
            
            self.refreshControl.endRefreshing()
            
        }
        
        self.updatePulltorefreshTitle()
        
        self.itemListCollectionView.reloadData()
        
    }
    
    func getHomeOffersConnectionFailure() {
        
        if self.refreshControl.isRefreshing {
            
            self.refreshControl.endRefreshing()
            
        }
        
        self.handleActivityIndicator(animate: false)
        
    }
    
}

extension ItemsListViewController : getMobilesConnectionDelegate {
    func getMobilesConnectionSuccess() {
        
        self.handleActivityIndicator(animate: false)
        
        self.mobileDataSource = Mobiles.getMobiles()
        
        if self.refreshControl.isRefreshing {
            
            self.refreshControl.endRefreshing()
            
        }
        
        self.updatePulltorefreshTitle()
        
        self.itemListCollectionView.reloadData()
        
    }
    
    func getMobilesConnectionFailure() {
        
        if self.refreshControl.isRefreshing {
            
            self.refreshControl.endRefreshing()
            
        }
        
        self.handleActivityIndicator(animate: false)
        
    }
    
}

extension ItemsListViewController : getAccessoriesConnectionDelegate {
    
    func getAccessoriesSuccess() {
        
        self.handleActivityIndicator(animate: false)
        
        self.accessoriesDataSource = Accessories.getAccessories()
        
        if self.refreshControl.isRefreshing {
            
            self.refreshControl.endRefreshing()
            
        }
        
        self.updatePulltorefreshTitle()
        
        self.itemListCollectionView.reloadData()
        
    }
    
    func getAccessoriesFailure() {
        
        if self.refreshControl.isRefreshing {
            
            self.refreshControl.endRefreshing()
            
        }
        
        self.handleActivityIndicator(animate: false)
        
    }
    
}


