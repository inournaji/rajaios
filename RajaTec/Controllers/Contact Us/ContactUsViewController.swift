//
//  ContactUsViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameUnderLineView: UIView!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mobileUnderLineView: UIView!
    @IBOutlet weak var mobileErrorLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageUnderLineView: UIView!
    @IBOutlet weak var messageErrorLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: - Variables
    var fadeView: UIView = UIView()
    var currentMenuX:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTextField.delegate = self
        self.mobileTextField.delegate = self
        self.messageTextField.delegate = self

        self.nameTextField.becomeFirstResponder()
        
        self.configureRevealMenu()
        
        self.setMenuFadeView()
        
        self.searchButton.tintColor = RajaColors.headerRedColor.getColor()
        
        self.menuButton.tintColor = RajaColors.headerRedColor.getColor()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func sumbitAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.present(SearchViewController.getInstance(), animated: true, completion: nil)
        
    }
    
}

extension ContactUsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let nameText = self.nameTextField.text, nameText.isEmpty {
            
            self.nameUnderLineView.backgroundColor = RajaColors.headerRedColor.getColor()
            
            self.nameErrorLabel.text = NSLocalizedString("Name cannot be empty", comment: "")
            
        } else {
            
            self.nameUnderLineView.backgroundColor = UIColor.lightGray
            
            self.nameErrorLabel.text = ""
            
        }
        
        if let mobileText = self.mobileTextField.text {
            
            self.mobileUnderLineView.backgroundColor = RajaColors.headerRedColor.getColor()
            
            if mobileText.isEmpty {
                
                self.mobileErrorLabel.text = NSLocalizedString("Mobile cannot be empty", comment: "")
                
            } else if mobileText.characters.count < 10 {
                
                self.mobileErrorLabel.text = NSLocalizedString("Mobile cannot be less than 10 characters", comment: "")
                
            } else {
            
                self.mobileUnderLineView.backgroundColor = UIColor.lightGray
            
                self.mobileErrorLabel.text = ""
            
            }
            
        }
        if let messageText = self.messageTextField.text {

            self.messageUnderLineView.backgroundColor = RajaColors.headerRedColor.getColor()
            
            if messageText.isEmpty {
                
                self.messageErrorLabel.text = NSLocalizedString("Message cannot be empty", comment: "")
                
            } else if messageText.characters.count < 10 {
                
                self.messageErrorLabel.text = NSLocalizedString("Message cannot be less than 10 characters", comment: "")
                
            } else {
                
                self.messageUnderLineView.backgroundColor = UIColor.lightGray
                
                self.messageErrorLabel.text = ""
                
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let searchCount = textField.text!.characters.count + (string.characters.count - range.length)
        
        var maximumCharactersCount = 0
        
        if textField == nameTextField {
            
            maximumCharactersCount = 40
            
        } else if textField == mobileTextField {
            
            maximumCharactersCount = 15
            
        } else if textField == messageTextField {
            
            maximumCharactersCount = 80
            
        }
        
        return searchCount <= maximumCharactersCount
        
    }
    
}

extension ContactUsViewController : SWRevealViewControllerDelegate {
    
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

extension ContactUsViewController {
    
    static public func getInstance() -> ContactUsViewController {
        
        let contactUsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsViewControllerID") as? ContactUsViewController
        
        return contactUsViewController!
        
    }
    
}
