//
//  UISearchBar+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

public extension UISearchBar {
    
    public func setBackgroundColor(color: UIColor) {
        if let textfield = value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
    }
    
    public func hideCancelButton(hide: Bool) {
        if let button = value(forKey: "cancelButton") as? UIButton {
            button.isHidden = hide
        }
    }
    
}
