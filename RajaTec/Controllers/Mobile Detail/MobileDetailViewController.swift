//
//  MobileDetailViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/10/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class MobileDetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var mobileTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var gallaryCollectionView: UICollectionView!
    @IBOutlet weak var mobileDetailTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nextImageAction(_ sender: Any) {
    }
    
    @IBAction func previousImageAction(_ sender: Any) {
    }
    
    
}

