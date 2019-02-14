//
//  UIColor+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit

public extension UIColor {
    
    static var error: UIColor { return UIColorFromRGB(0xee3939) }
    
    static func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

