//
//  TwitterManager.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation
import Social
import Accounts

protocol TwitterManagerDelegate: class {
    func twitter(_ manager: TwitterManager, new tweet: Tweet)
    func twitter(_ manager: TwitterManager, error: TweetError)
}

/// Class that handle fetching of data from server side and steps of login before that.
class TwitterManager: NSObject {
    let streamURL = URL(string: "https://stream.twitter.com/1.1/statuses/filter.json")!
    var session: URLSession!
    weak var delegate: TwitterManagerDelegate?
    
    override init() {
        super.init()
        self.session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
}

extension TwitterManager {
    
    func openAccessAtTwitterAccount(key text: String) {
        
        if !self.isAccessAvailable {
            self.delegate?.twitter(self, error: TweetError(message: Message.error.forbiddenSettingsAccess ))
            return
        }
        
        let store = ACAccountStore()
        let accountType = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        store.requestAccessToAccounts(with: accountType, options: nil) { (granted, error) in
            if let error = error {
                self.delegate?.twitter(self, error: TweetError(message: error.localizedDescription))
                return
            }
            
            if !granted {
                self.delegate?.twitter(self, error: TweetError(message: Message.error.forbiddenAccountAccess))
                return
            }
            
            let accounts = store.accounts(with: accountType)
            
            if let account = accounts?.last as? ACAccount {
                self.fetchNewTweets(at: account, for: text)
            } else {
                self.delegate?.twitter(self, error: TweetError(message: Message.error.forbiddenSettingsAccess))
            }
        }
    }
    
    private func fetchNewTweets(at account: ACAccount, for text: String) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .POST,
                                url: self.streamURL,
                                parameters: ["track": text])
        
        request?.account = account
        
        if let urlRequest = request?.preparedURLRequest() {
            self.session.dataTask(with: urlRequest).resume()
        }
    }
    
    var isAccessAvailable: Bool {
        return SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
    }
    
}


/// Hadle URLSessionDataDelegate calls on success and failure.
extension TwitterManager: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let tweet = Tweet(json) {
                    self.delegate?.twitter(self, new: tweet)
                }
            }
            
        } catch  {
            //Handle json errors
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            self.delegate?.twitter(self, error: TweetError(message: error.localizedDescription))
        }
    }
}
