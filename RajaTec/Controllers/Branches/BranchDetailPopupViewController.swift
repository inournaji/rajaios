//
//  BranchDetailPopupViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/24/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import Presentr

class BranchDetailPopupViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressBottomConstraint: NSLayoutConstraint!
    
    
    //Variables
    var branch: Branch?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePopup)))
        
        if let branch = self.branch {
            
            titleLabel.text = branch.title
            
            phoneNumberLabel.text = branch.phoneNumber
            
            addressLabel.text = branch.address
            
            addressBottomConstraint.constant = addressLabel.text?.isEmpty ?? false ? 0 : 20
            
        }
        
    }
    
    @objc func closePopup() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension BranchDetailPopupViewController {
    
    @discardableResult
    static func present(fromController controller: UIViewController, branch: Branch) -> BranchDetailPopupViewController {
        
        let branchDetailPopupViewController = BranchDetailPopupViewController(nibName: "BranchDetailPopupViewController", bundle: nil)
        
        branchDetailPopupViewController.branch = branch
        
        let presentationType: PresentationType = .custom(width: ModalSize.full, height: ModalSize.full, center: ModalCenterPosition.center)
        
        let presenter = Presentr(presentationType: presentationType)
        
        presenter.roundCorners = false
        presenter.transitionType = TransitionType.coverVertical
        
        presenter.backgroundOpacity = 0.45
        
        controller.customPresentViewController(presenter, viewController: branchDetailPopupViewController, animated: true, completion: nil)
        
        return branchDetailPopupViewController
        
    }
    
}
