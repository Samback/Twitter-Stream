//
//  TweetsViewController.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation
import UIKit

/// TweetsViewController - present list of tweets related for custom word.
class TweetsViewController: UIViewController {
   
    private let titleKey = "london"
    private var dataSource: TweetsDataSourceController!
    private var modelController: TweetsModelController!
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    private func config() {
        
        self.title = "@\(titleKey)"
        
        self.modelController = TweetsModelController(word: titleKey)
        self.modelController.delegate = self
        
        self.dataSource = TweetsDataSourceController(modelController: modelController)
        self.tableView.estimatedRowHeight = 50
        self.tableView.dataSource = dataSource
    }    
}

extension TweetsViewController: TweetsModelControllerDelegate {
    
    /// This method related to changing of UI based on stream updates.
    ///
    /// - parameter modelController: controller that manage updates of tweets store.
    /// - parameter insert:          index of cell should be input a new tweet.
    /// - parameter remove:          index what should be removed.
    func tweetsUpdate(modelController: TweetsModelController, itemIndex insert: IndexPath, itemIndex remove: IndexPath?) {
        
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [insert], with: .top)
            if let remove = remove {
                self.tableView.deleteRows(at: [remove], with: .fade)
            }
            self.tableView.endUpdates()
        }
    }
    
    /// In case of some erros this delegate method 'll
    ///
    /// - parameter modelController: controller that manage updates of tweets store.
    /// - parameter Manager:         controller that manage fetching of tweets.
    /// - parameter error:           one of the errors that could happen during login, parsing, etc.
    func tweetsError(modelController: TweetsModelController, twitter Manager: TwitterManager, error: TweetError) {
        
        DispatchQueue.main.async {
           self.present(UIAlertController.alert(error), animated: true, completion: nil)
        }
    }    
}
