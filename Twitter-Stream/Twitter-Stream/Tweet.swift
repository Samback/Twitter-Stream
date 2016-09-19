//
//  Tweet.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation

/// Tweet immutable struct that store info about custom tweet.
struct Tweet {
    let message: String
}

extension Tweet {
    
    init?(_ json: [String: Any]) {
        
        guard let message = json["text"] as? String else {
            return nil
        }
        
        self.message = message
    }
}
