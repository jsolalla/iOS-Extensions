//
//  Data+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit

public extension Data {
    
    /// Returns an hexadecimal string
    var hexString: String {
        return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
    }
    
    /// Returns a mutable attributted string from HTML data
    var htmlAttributedString: NSMutableAttributedString? {
        do {
            return try NSMutableAttributedString(data: self, options:
                [.documentType: NSAttributedString.DocumentType.html,
                 .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    /// Returns an string from HTML data
    var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
    
}
