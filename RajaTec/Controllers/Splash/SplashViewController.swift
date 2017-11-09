//
//  SplashViewController.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/6/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SplashViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var splash1ImageView: UIImageView!
    @IBOutlet weak var splash2ImageView: UIImageView!
    @IBOutlet weak var splash3ImageView: UIImageView!
    @IBOutlet weak var splash4ImageView: UIImageView!
    @IBOutlet weak var splash5ImageView: UIImageView!
    @IBOutlet weak var splash6ImageView: UIImageView!
    @IBOutlet weak var splash7ImageView: UIImageView!
    @IBOutlet weak var splash8ImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIView!
    
    //MARK: - Variables
    var connectionActivityIndicator: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.splash1ImageView.alpha = 0
        self.splash2ImageView.alpha = 0
        self.splash3ImageView.alpha = 0
        self.splash4ImageView.alpha = 0
        self.splash5ImageView.alpha = 0
        self.splash6ImageView.alpha = 0
        self.splash7ImageView.alpha = 0
        self.splash8ImageView.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.congifureActivityIndicatorView()
        
        self.handleActivityIndicator(animate: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
        
            self.handleActivityIndicator(animate: false)
            
            let swReavealVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewControllerID")
            
            self.navigationController?.pushViewController(swReavealVC, animated: true)

        }
        
    }
    
    func animateSplashIcons() {
        
        UIView.animate(withDuration: 1, animations: {

            self.splash1ImageView.alpha = 0.7

        })
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseIn, animations: {

            self.splash5ImageView.alpha = 0.7

        }, completion: nil)

        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseIn, animations: {
            
            self.splash8ImageView.alpha = 0.7

        }, completion: nil)

        UIView.animate(withDuration: 1, delay: 1.5, options: .curveEaseIn, animations: {
            
            self.splash2ImageView.alpha = 0.7

        }, completion: nil)

        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseIn, animations: {

            self.splash6ImageView.alpha = 0.7

        }, completion: nil)

        UIView.animate(withDuration: 1, delay: 2.5, options: .curveEaseIn, animations: {

            self.splash4ImageView.alpha = 0.7

        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 3, options: .curveEaseIn, animations: {

            self.splash7ImageView.alpha = 0.7

        }, completion: nil)
        
        UIView.animate(withDuration: 15, delay: 0, options: .curveEaseIn, animations: {

            self.splash3ImageView.alpha = 0.7

        }) { (finished) in

            let swReavealVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewControllerID")

            self.navigationController?.pushViewController(swReavealVC, animated: true)

        }
        
    }
    
    func handleActivityIndicator(animate: Bool) {
        
        self.activityIndicatorView.isHidden = !animate
        
        if  animate {
            
            self.connectionActivityIndicator?.startAnimating()
            
        } else {
            
            self.connectionActivityIndicator?.stopAnimating()
            
        }
        
    }
    
    func congifureActivityIndicatorView() {
        
        let activityFrame = CGRect(x: 0, y: 0, width: activityIndicatorView.frame.width, height: activityIndicatorView.frame.height)
        
        connectionActivityIndicator = NVActivityIndicatorView(frame: activityFrame, type: .ballGridPulse, color: UIColor.white, padding: nil)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        activityIndicatorView.addSubview(connectionActivityIndicator!)
        
    }

}