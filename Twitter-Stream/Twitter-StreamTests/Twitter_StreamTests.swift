//
//  Twitter_StreamTests.swift
//  Twitter-StreamTests
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import XCTest

 @testable import TwitterStream

class Twitter_StreamTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTweetError() {
        let error = TweetError(message: "My error message")
        
        XCTAssertEqual(error.errorMessage, "My error message")
    }
    
    func testTweetInit() {
        let tweetSource = ["text": "Input text",
                           "user": "Test user"]
        
        let tweet = Tweet(tweetSource)
        XCTAssert(tweet?.message == "Input text", "Your tweet initizlizer is broken")             
    }    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
