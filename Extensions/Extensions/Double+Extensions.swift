//
//  Double+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import Foundation

public extension Double {
    
    /// Returns the number as String
    func toString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Returns the number as Int
    func toInt() -> Int {
        return Int(self)
    }
    
    /// Returns the number as CGFloat
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    /// Returns the number with currency format
    func toCurrency(symbol: String = "$") -> String {
        let formatter = NumberFormatter()
        formatter.currencySymbol = symbol
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "\(symbol)0.0"
    }
    
}
