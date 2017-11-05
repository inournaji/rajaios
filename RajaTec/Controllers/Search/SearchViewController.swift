//
//  SearchViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/5/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var searchResultLabel: UILabel!
    
    //MARK: - Variables
    var searchItems: [Any] = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
                
        self.collectionView.register(UINib(nibName: "MobileAccessoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MobileAccessoriesCollectionViewCellID")
        
        self.fadeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeFade)))
        
        self.searchResultLabel.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchBar.becomeFirstResponder()
        
    }

    @IBAction func closeAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    @objc func removeFade() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.fadeView.alpha = 0
            
        }) { (finished) in
            
            self.fadeView.isHidden = true
            
        }
        
        self.view.endEditing(true)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    
        self.fadeView.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.fadeView.alpha = 0.7
            
        })
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchItems.removeAll()
        
        if !searchText.isEmpty {
        
            self.searchItems.append(contentsOf: Mobiles.getMobiles(with: searchText))
            
            self.searchItems.append(contentsOf: Accessories.getAccessoriesAny())
            
            self.searchResultLabel.isHidden = self.searchItems.count > 0 ? true : false
            
        } else {
            
            self.searchResultLabel.isHidden = true
            
        }
        
        self.collectionView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let searchCount = searchBar.text!.characters.count + (text.characters.count - range.length)

        return searchCount <= 15
        
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.searchItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let mobileItem = self.searchItems[indexPath.item] as? Mobile {
            
            let mobileCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MobileAccessoriesCollectionViewCellID", for: indexPath) as? MobileAccessoriesCollectionViewCell
            
            mobileCell?.configureCell(mobile: mobileItem)
            
            return mobileCell!
            
        } else if let accessoryItem = self.searchItems[indexPath.item] as? Accessory {
            
            let mobileCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MobileAccessoriesCollectionViewCellID", for: indexPath) as? MobileAccessoriesCollectionViewCell
            
            mobileCell?.configureCell(accessoryItem: accessoryItem)
            
            return mobileCell!
            
        } else {
            
            return UICollectionViewCell()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return ListType.mobile.getCellSize()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let mobileItem = self.searchItems[indexPath.item] as? Mobile {
            
            self.navigationController?.pushViewController(MobileDetailViewController.getInstance(mobileItem: mobileItem), animated: true)
            
        }
        
    }
    
}

extension SearchViewController {
    
    static public func getInstance() -> UINavigationController {
        
        let searchNavViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchNavViewController") as? UINavigationController
        
        return searchNavViewController!
        
    }
    
}
