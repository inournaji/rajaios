//
//  BranchesViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/24/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class BranchesViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var connectionErrorButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variables
    var fadeView: UIView = UIView()
    var currentMenuX:CGFloat = 0
    var branchesRequest: DataRequest?
    var branches = Branches.getBranches()
    var requestIsInBackground: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureRevealMenu()
        
        self.setMenuFadeView()
        
        self.searchButton.tintColor = RajaColors.headerRedColor.getColor()
        
        self.menuButton.tintColor = RajaColors.headerRedColor.getColor()
        
        self.mapView.delegate = self
        
        self.mapView.mapType = MKMapType.standard

        self.handleBranches()
    }
    
    func handleBranches() {
        
        if self.branches.count > 0 {
            
            self.requestIsInBackground = true
            
            self.refreshMapAnnotations()
            
        } else {
            
            self.activityIndicator.startAnimating()
            
            self.requestIsInBackground = false
            
            Connection.getBranches(delegate: self)
            
        }
        
    }
    
    func refreshMapAnnotations() {
        
        self.mapView.isHidden = false
        
        for branch in self.branches {
            
            if let branchLat = branch.getLatitude(), let brancgLong = branch.getLongitude() {
                
                let branchAnnotation = BranchAnnotation(branch: branch, coordinate: CLLocationCoordinate2D(latitude: branchLat, longitude: brancgLong))
                
               self.mapView.addAnnotation(branchAnnotation)
                
            }
            
        }
        
    }
    
    

    @IBAction func searchAction(_ sender: Any) {
        
        self.present(SearchViewController.getInstance(), animated: true, completion: nil)
        
    }
    
    @IBAction func retryAction(_ sender: Any) {
        
        self.handleBranches()
        
    }
    
}

extension BranchesViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let branchAnnotaton = view.annotation as? BranchAnnotation {
            
            BranchDetailPopupViewController.present(fromController: self, branch: branchAnnotaton.branch)
            
        }
        
    }
    
}

class BranchAnnotation: NSObject, MKAnnotation {
    var branch = Branch()
    let coordinate: CLLocationCoordinate2D
    
    init(branch: Branch, coordinate: CLLocationCoordinate2D) {
        self.branch = branch
        self.coordinate = coordinate
        
        super.init()
    }
}

extension BranchesViewController: getBranchesConnectionDelegate {
    
    func getBranchesConnectionSuccess() {
        
        self.activityIndicator.stopAnimating()
        
        self.branches = Branches.getBranches()
        
        if !self.requestIsInBackground {
            
            self.connectionErrorButton.isHidden = self.branches.count > 0 ? true : false
            
            self.mapView.isHidden = self.branches.count > 0 ? false : true
            
            
        }
        
        self.refreshMapAnnotations()
        
    }
    
    func getBranchesConnectionFailure() {
        
        self.activityIndicator.stopAnimating()
        
        if !self.requestIsInBackground {
            
            self.connectionErrorButton.isHidden = false
            
            self.mapView.isHidden = true
            
        }
        
    }
    
}



extension BranchesViewController : SWRevealViewControllerDelegate {
    
    //MARK: Menu Functions
    func configureRevealMenu() {
        
        self.revealViewController().delegate = self
        
        if self.revealViewController() != nil {
            
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().panGestureRecognizer().addTarget(self, action: #selector(BranchesViewController.handlePanGesture(panGesture:)))
            
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
    
    func revealController(_ revealController: SWRevealViewController!, willAdd viewController: UIViewController!, for operation: SWRevealControllerOperation, animated: Bool) {
        
        self.branchesRequest?.cancel()
        
    }
    
    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        
        return true
    }
    
}

extension BranchesViewController {
    
    static public func getInstance() -> BranchesViewController {
        
        let branchesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BranchesViewControllerID") as? BranchesViewController
        
        return branchesViewController!
        
    }
    
}
