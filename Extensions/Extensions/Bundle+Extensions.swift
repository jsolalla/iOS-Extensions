//
//  Bundle+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import Foundation

public extension Bundle {
    
    /// Returns the current version of the project
    var releaseVersionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
    }
    
    /// Returns the current build number of the project
    var buildVersionNumber: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }
    
}
