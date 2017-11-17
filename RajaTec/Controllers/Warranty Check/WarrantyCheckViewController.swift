//
//  WarrantyCheckViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class WarrantyCheckViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var warrantyTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mobileErrorLabel: UILabel!
    @IBOutlet weak var mobileUnderLineView: UIView!
    @IBOutlet weak var loaderFadeView: UIView!
    @IBOutlet weak var loaderView: UIView!
    
    @IBOutlet weak var warrantyDetailView: UIView!
    @IBOutlet weak var imeiLabel: UILabel!
    @IBOutlet weak var imeiValueLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDateValueLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateValueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesValueLabel: UILabel!
    
    
    //MARK: - Variables
    var fadeView: UIView = UIView()
    var currentMenuX:CGFloat = 0
    var warrantyRequestLoader: NVActivityIndicatorView?
    var warrantyRequest: DataRequest?
    var warranty = WarrantyCachingModel.getWarranty()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureRevealMenu()
        
        self.setMenuFadeView()
        
        self.searchButton.tintColor = RajaColors.headerRedColor.getColor()
        
        self.menuButton.tintColor = RajaColors.headerRedColor.getColor()
        
        if let _ = self.warranty {
            
            self.handleWarrantyDetailView(withAnimation: false)
            
        } else {
            
            self.initToolbar()
            
            self.warrantyTextField.delegate = self
            
            self.mobileTextField.delegate = self
            
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.warranty == nil {
            
            self.warrantyTextField.becomeFirstResponder()
            
            self.congifureActivityIndicatorView()
            
        }
        
    }
    
    func congifureActivityIndicatorView() {
        
        let activityFrame = CGRect(x: 0, y: 0, width: loaderView.frame.width, height: loaderView.frame.height)
        
        warrantyRequestLoader = NVActivityIndicatorView(frame: activityFrame, type: .ballSpinFadeLoader, color: RajaColors.headerRedColor.getColor(), padding: nil)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        loaderView.addSubview(warrantyRequestLoader!)
        
    }
    
    func handleWarrantyDetailView(withAnimation: Bool) {
        
        if withAnimation {
            
            self.warrantyDetailView.isHidden = false
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.warrantyDetailView.alpha = 1
                
            })
            
        } else {
            
            self.warrantyDetailView.isHidden = false
            
            self.warrantyDetailView.alpha = 1
            
        }
        
        self.initializeWarrantyDetailView()
        
    }
    
    func initializeWarrantyDetailView() {
        
        if let warranty = self.warranty {
            
            imeiValueLabel.text = warranty.imei1
                        
            startDateValueLabel.text = warranty.start_date
            
            endDateValueLabel.text = warranty.end_date
            
            statusValueLabel.text = warranty.status
            
            notesValueLabel.text = warranty.notes
            
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.present(SearchViewController.getInstance(), animated: true, completion: nil)
        
    }
    
    @IBAction func checkWarrantyAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        //Send the request
        if self.errorLabel.text!.isEmpty && self.mobileErrorLabel.text!.isEmpty {
            
            self.handleWarrantyRequestLoader(show: true)
            
            self.warrantyRequest = Connection.warrantyActivationRequest(mobileNumber: mobileTextField.text!, imei: warrantyTextField.text!, delegate: self)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
}

extension WarrantyCheckViewController: UITextFieldDelegate {
    
    func initToolbar() {
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        
        toolbar.sizeToFit()
        
        //setting toolbar as inputAccessoryView
        self.warrantyTextField.inputAccessoryView = toolbar
        
        self.mobileTextField.inputAccessoryView = toolbar
        
    }
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let enteredText = textField.text,
            textField == warrantyTextField {
            
            if enteredText.isEmpty || enteredText.characters.count < 10 {
                
                self.underLineView.backgroundColor = RajaColors.headerRedColor.getColor()
                
                self.errorLabel.text = NSLocalizedString("Please enter IMEI code", comment: "")
                
            } else {
                
                self.underLineView.backgroundColor = UIColor.lightGray
                
                self.errorLabel.text = ""
                
            }
            
        }
        
        if let enteredText = textField.text,
            textField == mobileTextField {
            
            if !enteredText.isEmpty && !enteredText.isPhoneNumber {
                
                self.mobileUnderLineView.backgroundColor = RajaColors.headerRedColor.getColor()
                
                self.mobileErrorLabel.text = NSLocalizedString("Please enter a valid mobile number", comment: "")
                
            } else {
                
                self.mobileUnderLineView.backgroundColor = UIColor.lightGray
                
                self.mobileErrorLabel.text = ""
                
            }
            
        }
        
    }
    
    func handleWarrantyRequestLoader(show: Bool) {
        
        if show {
            
            self.loaderFadeView.isHidden = false
            
            self.loaderView.isHidden = false
            
            self.warrantyRequestLoader?.startAnimating()
            
            UIView.animate(withDuration: 1) {
                
                self.loaderFadeView.alpha = 0.9
                
            }
            
        } else {
            
            self.warrantyRequestLoader?.stopAnimating()
            
            self.loaderFadeView.isHidden = true
            
            self.loaderView.isHidden = true
            
            self.loaderFadeView.alpha = 0
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let searchCount = textField.text!.characters.count + (string.characters.count - range.length)
        
        var maximumCharactersCount = 15
        
        if textField == mobileTextField {
            
            maximumCharactersCount = 9
            
        }
        
        return searchCount <= maximumCharactersCount
        
    }
    
}

extension WarrantyCheckViewController: warrantyActivationConnectionDelegate {
    
    func warrantyActivationSuccess(warranty: Warranty) {
        
        self.warranty = warranty
        
        WarrantyCachingModel.storeWarranty(warranty: warranty)
        
        self.handleWarrantyRequestLoader(show: false)
        
        self.handleWarrantyDetailView(withAnimation: true)
        
    }
    
    func warrantyActivationFailure(errorMessage: String) {
        
        self.handleWarrantyRequestLoader(show: false)
        
        let alerConfiguration = AlertPopup.AlertConfiguration(title: NSLocalizedString("Error", comment: ""), message: errorMessage, withOkButton: false, withRetryButton: true, withCancelButton: true)
        
        let alertPopup = AlertPopup.getAlertPopup(alertConfiguration: alerConfiguration) {
            
            self.handleWarrantyRequestLoader(show: true)
            
            self.warrantyRequest = Connection.warrantyActivationRequest(mobileNumber: self.mobileTextField.text!, imei: self.warrantyTextField.text!, delegate: self)
            
        }
        
        self.present(alertPopup, animated: true, completion: nil)
        
    }
    
    
}

extension WarrantyCheckViewController : SWRevealViewControllerDelegate {
    
    //MARK: Menu Functions
    func configureRevealMenu() {
        
        self.revealViewController().delegate = self
        
        if self.revealViewController() != nil {
            
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().panGestureRecognizer().addTarget(self, action: #selector(WarrantyCheckViewController.handlePanGesture(panGesture:)))
            
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
        
        self.warrantyRequest?.cancel()
        
    }
    
    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        
        return true
    }
    
}

extension WarrantyCheckViewController {
    
    static public func getInstance() -> WarrantyCheckViewController {
        
        let warrantyCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WarrantyCheckViewControllerID") as? WarrantyCheckViewController
        
        return warrantyCheckViewController!
        
    }
    
}

