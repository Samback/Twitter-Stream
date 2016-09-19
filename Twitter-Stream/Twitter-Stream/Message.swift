//
//  Message.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation

/// Helper struct to hold text things at one place.
struct Message {    
    private init() {}
    
    static let error = ErrorMessages()
    static let appName = "Twitter Stream"
    static let ok = "OK"
}

struct ErrorMessages {
    
    let forbiddenSettingsAccess = "Your device didn't contain any twitter account."
    let forbiddenAccountAccess = "Please give us permissions for your twitter account."
}
