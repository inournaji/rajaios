//
//  HomeDashboardViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

enum BottomBarItem : String{
    case main
    case mobiles
    case accessories
    
    func getItemsListType() -> ListType{
        
        switch self {
            
        case .main:
            return .Home
            
        case .mobiles:
            return .mobile
            
        case .accessories:
            return .accessories
            
        }
        
    }
    
    func getTitle() -> String {
        
        switch self {
            
        case .main:
            return NSLocalizedString("Main", comment: "")
            
        case .mobiles:
            return NSLocalizedString("Mobiles", comment: "")
            
        case .accessories:
            return NSLocalizedString("Accessories", comment: "")
            
        }
        
    }
    
    static func getBottomBarsItems() -> [BottomBarItem] {
        
        return [.main, .mobiles, .accessories]
        
    }
    
    func getBottomBarItemIndexPath() -> IndexPath {
        
        switch self {
            
        case .main:
            return IndexPath(item: 0, section: 0)
            
        case .mobiles:
            return IndexPath(item: 1, section: 0)
            
        case .accessories:
            return IndexPath(item: 2, section: 0)
            
        }
        
    }
}

class HomeDashboardViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var bottomBarCollectionView: UICollectionView!
    @IBOutlet weak var containerViewController: UIView!
    
    //MARL: - Variables
    var bottomBarItems: [BottomBarItem] = BottomBarItem.getBottomBarsItems()
    var fadeView: UIView = UIView()
    var currentMenuX:CGFloat = 0
    var itemListViewControllerSugue = "itemListViewControllerSugue"
    var itemsListViewControllers: ItemsListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureBottomBar()
        
        self.setMenuFadeView()
        
        self.configureRevealMenu()
        
        self.searchButton.tintColor = RajaColors.headerRedColor.getColor()
        
        self.menuButton.tintColor = RajaColors.headerRedColor.getColor()
        
        
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        
        
    }
    
}

extension HomeDashboardViewController : SWRevealViewControllerDelegate {
    
    //MARK: Menu Functions
    func configureRevealMenu() {
        
        self.revealViewController().delegate = self
        
        if self.revealViewController() != nil {
            
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().panGestureRecognizer().addTarget(self, action: #selector(HomeDashboardViewController.handlePanGesture(panGesture:)))
            
        }
        
    }
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        self.view.addSubview(fadeView)
        
        let x = self.revealViewController().frontViewController.view.superview?.frame.origin.x
        
        if x == 0 { // menu completly closed
            fadeView.alpha = 0
            fadeView.removeFromSuperview()
        }
            
        else {
            
            if x! > currentMenuX && x != self.revealViewController().frontViewController.view.superview?.frame.width {
                
                if (fadeView.alpha) <= CGFloat(0.7) && x! >= CGFloat(60) {
                    
                    fadeView.alpha += 0.02
                }
            }
            else if x! < currentMenuX && x != self.revealViewController().frontViewController.view.superview?.frame.width  {
                
                fadeView.alpha -= 0.02
            }
        }
        
        currentMenuX = x!
        
    }
    
    func setMenuFadeView() {
        
        fadeView = UIView(frame: self.view.bounds)
        fadeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        fadeView.alpha = 0
        fadeView.backgroundColor = UIColor.black
        let swipeGesture = UISwipeGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        swipeGesture.direction = .left
        fadeView.addGestureRecognizer(swipeGesture)
        
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        
        let menuHiddenPosition = FrontViewPosition.right
        let menuShownPosition = FrontViewPosition.left
        
        if revealController.frontViewPosition == menuHiddenPosition { // hide menu
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.fadeView.alpha = 0
            }, completion: {(finished: Bool) in
                
                self.fadeView.removeFromSuperview()
            }
            )
            
            
        } else if revealController.frontViewPosition == menuShownPosition { // show menu
            
            UIView.animate(withDuration: 0.25) { () -> Void in
                self.fadeView.alpha = 0.7
            }
            
            self.view.addSubview(fadeView)
            
            
        }
    }
    
    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == itemListViewControllerSugue {
            
            if let itemListNavVC = segue.destination as? UINavigationController {
                
                if let itemListVC = itemListNavVC.viewControllers[0] as? ItemsListViewController {
                    
                    self.itemsListViewControllers = itemListVC
                    
                    self.itemsListViewControllers?.itemsListViewControllerDelegate = self
                    
                }
                
            }
            
        }
        
    }
    
}

extension HomeDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureBottomBar() {
        
        self.bottomBarCollectionView.delegate = self
        
        self.bottomBarCollectionView.dataSource = self
        
        self.bottomBarCollectionView.register(UINib(nibName: "BottomBarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BottomBarCollectionViewCellID")
        
        self.bottomBarCollectionView.selectItem(at: bottomBarItems[0].getBottomBarItemIndexPath(), animated: false, scrollPosition: .left)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return bottomBarItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bottomBarCell = self.bottomBarCollectionView.dequeueReusableCell(withReuseIdentifier: "BottomBarCollectionViewCellID", for: indexPath) as? BottomBarCollectionViewCell
        
        bottomBarCell?.configure(title: bottomBarItems[indexPath.item].getTitle())
        
        return bottomBarCell ?? bottomBarCell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width / 3
        
        let height = UIScreen.main.bounds.height
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.itemsListViewControllers?.changeListType(listType: bottomBarItems[indexPath.item].getItemsListType())
        
    }
    
}

extension HomeDashboardViewController: ItemsListViewControllerDelegate {
    
    func userDidSelectMobile(selectedMobile: Mobile) {
        
        //TODO: Push The inner mobile detail screen and send the mobile object
        
    }
    
    func userDidSelectOffer(selectedOffer: Offer) {
        
        //TODO: open offer link
        
    }
    
    func userDidSelectAccessory(selectedAccessory: Accessory) {
        
        //TODO: Future Implementation
        
    }
    
}


