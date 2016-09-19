//
//  TweetsDataSourceController.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation
import UIKit

/// Source Controller that help manage table view logic.
class TweetsDataSourceController: NSObject {
    weak var modelController: TweetsModelController?
    
    init(modelController: TweetsModelController) {
        self.modelController = modelController
    }    
}

extension TweetsDataSourceController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController?.numberOfTweets ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        if let tweet = self.modelController?.tweet(at: indexPath) {
            cell.message.text = tweet.message
        }
        
        return cell
    }
}
