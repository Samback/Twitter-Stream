//
//  UIAlertControllerExtension.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController {
    
    /// Helper class method that are using for showing error's messages.
    ///
    /// - parameter error: input error 
    ///
    /// - returns: UIAlertController
    class func alert(_ error: TweetError) -> UIAlertController {
        
        let alert = UIAlertController(title: Message.appName, message: error.errorMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: Message.ok, style: .default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
}
