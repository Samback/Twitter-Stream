//
//  TweetsModelController.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation

/// Delegate methods that react on new changes from server side or during connection.
protocol TweetsModelControllerDelegate: class {
    func tweetsUpdate(modelController: TweetsModelController, itemIndex insert: IndexPath, itemIndex remove: IndexPath?)
    func tweetsError(modelController: TweetsModelController, twitter Manager: TwitterManager, error: TweetError)
}

/// Controller that manage updates of tweets store.
class TweetsModelController {
    
    let maxNumberOfTweets = 5
    
    private let twitterManager = TwitterManager()
    private let key: String
    fileprivate var tweets = [Tweet]()
    
    weak var delegate: TweetsModelControllerDelegate?
    
    init(word key: String) {
        self.key = key
        twitterManager.openAccessAtTwitterAccount(key: key)
        twitterManager.delegate = self
    }
    
    var numberOfTweets: Int {
        return tweets.count
    }
    
    func tweet(at index: IndexPath) -> Tweet {
        return tweets[index.row]
    }
}

extension TweetsModelController: TwitterManagerDelegate {
    func twitter(_ manager: TwitterManager, new tweet: Tweet) {
        
        var remove: IndexPath?
        
        tweets.insert(tweet, at: 0)
        
        if tweets.count > maxNumberOfTweets {
            remove = IndexPath(row: maxNumberOfTweets - 1, section: 0)
            tweets.removeLast()
        }
        
        self.delegate?.tweetsUpdate(modelController: self, itemIndex: IndexPath(row: 0, section: 0), itemIndex: remove)
    }
    
    func twitter(_ manager: TwitterManager, error: TweetError) {
        self.delegate?.tweetsError(modelController: self, twitter: manager, error: error)
    }
}
