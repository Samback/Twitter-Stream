//
//  TweetError.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation

/// TweetError - simpl helper class that are using at alerts representation. 
struct TweetError: Error {
    
    let errorMessage: String
    
    init(message description: String) {
        self.errorMessage = description
    }
}
