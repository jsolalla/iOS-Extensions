//
//  UITextView+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

public extension UITextView {
    
    func hyperLink(originalText: String, hyperLink: String, urlString: String, textAttributes: [NSAttributedString.Key: Any], linkAttributes: [NSAttributedString.Key: Any]) {
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let allRange = NSMakeRange(0, originalText.count)
        let attributedString = NSMutableAttributedString(string: originalText)
        attributedString.addAttributes(textAttributes, range: allRange)
        attributedString.addAttributes([.paragraphStyle: style], range: allRange)
        
        if let hyperLinkRange = originalText.range(of: hyperLink), let URL = URL(string: urlString) {
            let range = originalText.nsRange(from: hyperLinkRange)
            attributedString.addAttributes([.link: URL], range: range)
            attributedString.addAttributes(linkAttributes, range: range)
        }
        
        isHidden = false
        attributedText = attributedString
        isUserInteractionEnabled = true
        isEditable = false
        isScrollEnabled = false
    }
    
}
