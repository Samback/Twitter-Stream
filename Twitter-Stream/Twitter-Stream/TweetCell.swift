//
//  TweetCell.swift
//  Twitter-Stream
//
//  Created by Max Tymchii on 9/19/16.
//  Copyright © 2016 SambackInc. All rights reserved.
//

import Foundation
import  UIKit

/// Custom TweetCell
class TweetCell: UITableViewCell {
    
    @IBOutlet var message: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configLabel()
    }
    
    private func configLabel() {
        
        self.message.backgroundColor = .lightGray
        self.message.layer.cornerRadius = 5
        self.message.clipsToBounds = true
    }
}
