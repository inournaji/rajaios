//
//  SideMenuTableViewCell.swift
//  RajaTec
//
//  Created by Ammar Arangy on 9/30/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuIconImageView: UIImageView!
    @IBOutlet weak var closeMenuButton: UIButton!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var expandTableView: UITableView!
    @IBOutlet weak var expandView: UIView!
    @IBOutlet weak var expandViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    
    //MARK: - Variables
    var menuItem: MenuItem = MenuItem.close
    var expandItems = [ExpandItem]()
    var expandRowHeight = 40
    var expandHeight: CGFloat = 0
    
    weak var sideMenuExpandDelegate: sideMenuExpandDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.expandTableView.delegate = self
        
        self.expandTableView.dataSource = self
        
        self.expandTableView.register(UINib(nibName: "ExpandTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandTableViewCellID")
                
    }
    
    func configure(menuItem: MenuItem, delegate: sideMenuExpandDelegate? = nil) {
        
        self.menuItem = menuItem
        
        self.expandItems = menuItem.getExpandOptions()
        
        self.calculateExpandViewHeight()
        
        switch menuItem {
        case .close:
            
            self.configureCloseCell()
            
        case .language:
            
            self.ConfigureLanguageCell()
        
        case .contactUS, .gallary, .home, .joinUsonFacebook, .termsAndConditions, .warranty, .offers:
            
            self.configureMenuItemCell(delegate: delegate)
            
        }
        
        
    }
    
    func configureCloseCell() {
        
        self.closeMenuButton.setImage(self.menuItem.getIcon(), for: .normal)
        
        self.closeMenuButton.isHidden = false
        
        self.menuIconImageView.isHidden = true
        
        self.menuTitleLabel.isHidden = true
        
        self.menuView.isHidden = false
        
        self.languageView.isHidden = true
        
    }
    
    func configureMenuItemCell(delegate: sideMenuExpandDelegate? = nil) {
        
        self.menuIconImageView.image = self.menuItem.getIcon()
        
        self.menuTitleLabel.text = self.menuItem.getTitle()
        
        self.closeMenuButton.isHidden = true
        
        self.menuIconImageView.isHidden = false
        
        self.menuTitleLabel.isHidden = false
        
        self.menuView.isHidden = false
        
        self.languageView.isHidden = true
        
        self.sideMenuExpandDelegate = delegate
    }
    
    func ConfigureLanguageCell() {
    
        self.menuView.isHidden = true
        
        self.languageView.isHidden = false
    
    }
    
    func calculateExpandViewHeight() {
        
        if self.expandItems.count != 0  {
            
            self.expandHeight = CGFloat(self.expandItems.count * expandRowHeight)
            
            self.expandTableView.reloadData()
            
        } else {
            
             self.expandViewHeightCons.constant = 0
            
        }
        
    }

    func expandCollapse() {
        
        self.expandViewHeightCons.constant = self.expandViewHeightCons.constant == 0 ? expandHeight : 0
        
    }
    
    //MARK: - Actions
    @IBAction func englishTapAction(_ sender: Any) {
        
        if let englishButton = sender as? UIButton {
            
            self.languageSelection(buttonPressed: englishButton)
            
        }
        
    }
    
    @IBAction func arabicTapAction(_ sender: Any) {
    
        if let arabicButton = sender as? UIButton {
            
            self.languageSelection(buttonPressed: arabicButton)
            
        }
    
    }
    
    func languageSelection(buttonPressed: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.englishView.borderColor = buttonPressed == self.englishButton ? UIColor.black : UIColor.clear
            
            self.englishView.backgroundColor = buttonPressed == self.englishButton ? UIColor.lightGray : UIColor.clear
            
            self.arabicView.borderColor = buttonPressed == self.englishButton ? UIColor.clear : UIColor.black
            
            self.arabicView.backgroundColor = buttonPressed == self.englishButton ? UIColor.clear : UIColor.lightGray
            
        }
        
    }
    
}

extension SideMenuTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.expandItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let expandCell = expandTableView.dequeueReusableCell(withIdentifier: "ExpandTableViewCellID", for: indexPath) as? ExpandTableViewCell {
        
            expandCell.configure(expandItem: self.expandItems[indexPath.row])
            
            expandCell.selecetButon.tag = indexPath.row
            
            expandCell.selecetButon.addTarget(self, action: #selector(didSelectItemAtRow(sender:)), for: .touchUpInside)
            
            return expandCell
        
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
        
    }
    
    @objc func didSelectItemAtRow(sender: UIButton) {
        
        self.expandCollapse()
        
        self.sideMenuExpandDelegate?.expandItemClicked(expandItem: self.expandItems[sender.tag])
        
    }
    
}

