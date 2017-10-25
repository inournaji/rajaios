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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var gallaryCollectionView: UICollectionView!
    @IBOutlet weak var mobileDetailTableView: UITableView!
    
    var mobileItem: Mobile = Mobile()
    var currentGallaryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gallaryCollectionView.delegate = self
        self.gallaryCollectionView.dataSource = self
        
        self.gallaryCollectionView.register(UINib(nibName: "MobileGallaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MobileGallaryCollectionViewCellID")
        
        self.mobileDetailTableView.delegate = self
        self.mobileDetailTableView.dataSource = self
        
        self.mobileDetailTableView.register(UINib(nibName: "MobileDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MobileDetailTableViewCellID")
        
        self.mobileTitleLabel.text = self.mobileItem.title
        
        self.previousButton.isEnabled = self.currentGallaryIndex <= 0 ? false : true
        
        if let gallaryImages = self.mobileItem.image {
            
            self.nextButton.isEnabled = self.currentGallaryIndex == (gallaryImages.count - 1) ? false : true
            
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nextImageAction(_ sender: Any) {
        
        if let gallaryImages = self.mobileItem.image {
            
            if self.currentGallaryIndex < gallaryImages.count - 1 {
                
                self.currentGallaryIndex += 1
                
                let nextImageIndexPath = IndexPath(item: self.currentGallaryIndex, section: 0)
                
                self.gallaryCollectionView.scrollToItem(at: nextImageIndexPath, at: .centeredHorizontally, animated: true)
                
                self.nextButton.isEnabled = self.currentGallaryIndex == (gallaryImages.count - 1) ? false : true
             
                self.previousButton.isEnabled = true
                
            }
            
        }
        
    }
    
    @IBAction func previousImageAction(_ sender: Any) {
        
        if let _ = self.mobileItem.image {
            
            if self.currentGallaryIndex > 0 {
                
                self.currentGallaryIndex -= 1
                
                let nextImageIndexPath = IndexPath(item: self.currentGallaryIndex, section: 0)
                
                self.gallaryCollectionView.scrollToItem(at: nextImageIndexPath, at: .centeredHorizontally, animated: true)
                
                self.previousButton.isEnabled = self.currentGallaryIndex <= 0 ? false : true
                
                self.nextButton.isEnabled = true
                
            }
            
        }
        
    }
    
    
}
extension MobileDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mobileDetailCell = self.mobileDetailTableView.dequeueReusableCell(withIdentifier: "MobileDetailTableViewCellID", for: indexPath) as? MobileDetailTableViewCell
        
        let detailItem = self.mobileItem.getMobileDetailItem(index: indexPath.row)
        
        mobileDetailCell?.configure(with: detailItem.mainTitle, value: detailItem.value)
        
        return mobileDetailCell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    @objc func closeSideMenu() {
        
        if let revealMenu = self.revealViewController() {
            
            revealMenu.revealToggle(animated: true)
            
        }
        
    }
    
}

extension MobileDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.mobileItem.image?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCell = self.gallaryCollectionView.dequeueReusableCell(withReuseIdentifier: "MobileGallaryCollectionViewCellID", for: indexPath) as? MobileGallaryCollectionViewCell
        
        let imageUrl = self.mobileItem.image?[indexPath.item]
        
        imageCell?.configure(imageLink: imageUrl)
        
        return imageCell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let imageGallarySize = self.gallaryCollectionView.frame.size
        
        return imageGallarySize
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var visibleRect = CGRect()
        
        visibleRect.origin = self.gallaryCollectionView.contentOffset
        
        visibleRect.size = self.gallaryCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath: IndexPath = self.gallaryCollectionView.indexPathForItem(at: visiblePoint) {
            
            self.currentGallaryIndex = visibleIndexPath.item
            
            self.previousButton.isEnabled = self.currentGallaryIndex <= 0 ? false : true
            
            if let gallaryImages = self.mobileItem.image {
                
                self.nextButton.isEnabled = self.currentGallaryIndex == (gallaryImages.count - 1) ? false : true
                
            }
            
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    
    }
    
}

extension MobileDetailViewController {
    
    class public func getInstance(mobileItem: Mobile) ->  MobileDetailViewController{
        
        let mobileDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MobileDetailViewControllerID") as? MobileDetailViewController
        
        mobileDetailViewController?.mobileItem = mobileItem
        
        return mobileDetailViewController!
        
    }
    
}


