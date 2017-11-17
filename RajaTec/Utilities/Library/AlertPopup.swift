//
//  AlertPopup.swift
//  RajaTec
//
//  Created by Ammar Arangy on 11/17/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import Foundation

class AlertPopup {
    
    struct AlertConfiguration {
        
        var title = "Image"
        var message = "nid"
        var withOkButton = false
        var withRetryButton = false
        var withCancelButton = false
        
        init(title: String, message: String, withOkButton: Bool, withRetryButton: Bool, withCancelButton: Bool) {
            
            self.title = title
            self.message = message
            self.withOkButton = withOkButton
            self.withRetryButton = withRetryButton
            self.withCancelButton = withCancelButton
            
            
        }
        
    }
    
    class func getAlertPopup(alertConfiguration: AlertConfiguration, okCompletion: (()->Void)? = nil, cancelCompletion: (()->Void)? = nil, retryCompletion: (()->Void)? = nil) -> UIAlertController {
        
        let alertPopup = UIAlertController(title: alertConfiguration.title, message: alertConfiguration.message, preferredStyle: .alert)
        
        if alertConfiguration.withOkButton {
            
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action) in
                
                okCompletion?()
                
            }
            
            alertPopup.addAction(okAction)
            
        }
        
        if alertConfiguration.withRetryButton {
            
            let retryAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .default) { (action) in
                
                retryCompletion?()
                
            }
            
             alertPopup.addAction(retryAction)
            
        }
        
        if alertConfiguration.withCancelButton {
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
            { (action) in
                
                cancelCompletion?()
                
            }
            
            alertPopup.addAction(cancelAction)
            
        }
        
        return alertPopup
        
    }
    
}
