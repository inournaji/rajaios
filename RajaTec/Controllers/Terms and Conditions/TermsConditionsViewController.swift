//
//  TermsConditionsViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var termsConditionWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorButton: UIButton!
    
    //MARK: - Variables
    var fadeView: UIView = UIView()
    var currentMenuX:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchButton.tintColor = RajaColors.headerRedColor.getColor()
        
        self.menuButton.tintColor = RajaColors.headerRedColor.getColor()
        
        self.setMenuFadeView()
        
        self.configureRevealMenu()
        
        self.termsConditionWebView.delegate = self
        
        if let url = URL(string: "http://rajatec.net/ar/content/warantypolicy") {
        
            self.errorButton.isHidden = true
            
            self.activityIndicator.startAnimating()
            
            self.termsConditionWebView.loadRequest(URLRequest(url: url))
            
        }
        
    }
    
    @IBAction func retryAction(_ sender: Any) {
        
        if let url = URL(string: "http://rajatec.net/ar/content/warantypolicy") {
            
            self.errorButton.isHidden = true
            
            self.activityIndicator.startAnimating()
            
            self.termsConditionWebView.loadRequest(URLRequest(url: url))
            
        }
        
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.present(SearchViewController.getInstance(), animated: true, completion: nil)
        
    }
    
}

extension TermsConditionsViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.activityIndicator.stopAnimating()
        
        self.errorButton.isHidden = true
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        self.activityIndicator.stopAnimating()
        
        self.errorButton.isHidden = false
        
    }
    
}

extension TermsConditionsViewController : SWRevealViewControllerDelegate {
    
    //MARK: Menu Functions
    func configureRevealMenu() {
        
        self.revealViewController().delegate = self
        
        if self.revealViewController() != nil {
            
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().panGestureRecognizer().addTarget(self, action: #selector(TermsConditionsViewController.handlePanGesture(panGesture:)))
            
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
    
}

extension TermsConditionsViewController {
    
    static public func getInstance() -> TermsConditionsViewController {
        
        let termsConditionsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsConditionsViewControllerID") as? TermsConditionsViewController
        
        return termsConditionsViewController!
        
    }
    
}

