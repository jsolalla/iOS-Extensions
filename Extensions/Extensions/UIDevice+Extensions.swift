//
//  DeviceDetector.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

public enum Size: Int {
    
    case unknownSize = 0
    
    /// iPhone 4, 4s, iPod Touch 4th gen.
    case screen3_5Inch
    
    /// iPhone 5, 5s, 5c, SE, iPod Touch 5-6th gen.
    case screen4Inch
    
    /// iPhone 6, 6s, 7, 8
    case screen4_7Inch
    
    /// iPhone 6+, 6s+, 7+, 8+
    case screen5_5Inch
    
    /// iPhone X, Xs
    case screen5_8Inch
    
    /// iPhone Xr
    case screen6_1Inch
    
    /// iPhone Xs Max
    case screen6_5Inch
    
    /// iPad Mini
    case screen7_9Inch
    
    /// iPad
    case screen9_7Inch
    
    /// iPad Pro (10.5-inch)
    case screen10_5Inch
    
    /// iPad Pro (11-inch)
    case screen11Inch
    
    /// iPad Pro (12.9-inch)
    case screen12_9Inch
}

public enum Model: String {
    
    case simulator   = "simulator/sandbox",
    iPod1            = "iPod 1",
    iPod2            = "iPod 2",
    iPod3            = "iPod 3",
    iPod4            = "iPod 4",
    iPod5            = "iPod 5",
    iPad2            = "iPad 2",
    iPad3            = "iPad 3",
    iPad4            = "iPad 4",
    iPad5            = "iPad 5",
    iPad6            = "iPad 6",
    iPhone4          = "iPhone 4",
    iPhone4s         = "iPhone 4s",
    iPhone5          = "iPhone 5",
    iPhone5S         = "iPhone 5S",
    iPhone5C         = "iPhone 5C",
    iPadMini1        = "iPad Mini 1",
    iPadMini2        = "iPad Mini 2",
    iPadMini3        = "iPad Mini 3",
    iPadMini4        = "iPad Mini 4",
    iPadAir1         = "iPad Air 1",
    iPadAir2         = "iPad Air 2",
    iPadPro9_7       = "iPad Pro 9.7",
    iPadPro10_5      = "iPad Pro 10.5",
    iPadPro11        = "iPad Pro 11",
    iPadPro12_9      = "iPad Pro 12.9",
    iPhone6          = "iPhone 6",
    iPhone6Plus      = "iPhone 6 Plus",
    iPhone6s         = "iPhone 6s",
    iPhone6sPlus     = "iPhone 6s Plus",
    iPhoneSE         = "iPhone SE",
    iPhone7          = "iPhone 7",
    iPhone7Plus      = "iPhone 7 Plus",
    iPhone8          = "iPhone 8",
    iPhone8Plus      = "iPhone 8 Plus",
    iPhoneX          = "iPhone X",
    iPhoneXR         = "iPhone XR",
    iPhoneXS         = "iPhone XS",
    iPhoneXSMax      = "iPhone XS Max",
    unrecognized     = "?unrecognized?"
}

open class Device {
    
    enum UIUserInterfaceIdiom: Int {
        case unknown
        case phone
        case pad
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct ScreenType {
        static let _320 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_WIDTH == 320
        static let _375 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_WIDTH == 375
        static let _414 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_WIDTH == 414
    }
    
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6_7_8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P_7P_8P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X_XS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
        static let IS_IPHONE_XR_XSMax = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    }
    
    static func getInterfaceIdiom() -> UIUserInterfaceIdiom {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .phone
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return .pad
        } else {
            return .unknown
        }
    }
    
    static func getDeviceModel() -> String {
        return UIDevice.current.model
    }
    
    static func getTransitionPeriodSize() -> CGFloat {
        if ScreenType._375 {
            return 96
        } else if ScreenType._320 {
            return 110
        } else {
            return 80
        }
    }
    
    static public func size() -> Size {
        
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)
        
        switch screenHeight {
        case 480:
            return .screen3_5Inch
        case 568:
            return .screen4Inch
        case 667:
            return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
        case 736:
            return .screen5_5Inch
        case 812:
            return .screen5_8Inch
        case 896:
            return UIScreen.main.scale == 3.0 ? .screen6_5Inch : .screen6_1Inch
        case 1024:
            
            switch UIDevice.current.type {
            case .iPadMini1, .iPadMini2, .iPadMini3, .iPadMini4:
                return .screen7_9Inch
            case .iPadPro10_5:
                return .screen10_5Inch
            default:
                return .screen9_7Inch
            }
            
        case 1112:
            return .screen10_5Inch
        case 1194:
            return .screen11Inch
        case 1366:
            return .screen12_9Inch
        default:
            return .unknownSize
        }
    }
    
    static public func hasNotch() -> Bool {
        return Device.size() == .screen5_8Inch || Device.size() == .screen6_1Inch || Device.size() == .screen6_5Inch
    }
    
    static public func isPad() -> Bool {
        return Device.size() == .screen7_9Inch || Device.size() == .screen10_5Inch || Device.size() == .screen9_7Inch || Device.size() == .screen10_5Inch || Device.size() == .screen11Inch || Device.size() == .screen12_9Inch || Device.getInterfaceIdiom() == .pad
    }
    
}

public extension UIDevice {
    
    public var type: Model {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String.init(validatingUTF8: ptr) }
        }
        
        var modelMap: [String: Model ] = [
            
            // iPhone
            "i386": .simulator,
            "x86_64": .simulator,
            "iPhone3,1": .iPhone4,
            "iPhone3,2": .iPhone4,
            "iPhone3,3": .iPhone4,
            "iPhone4,1": .iPhone4s,
            "iPhone5,1": .iPhone5,
            "iPhone5,2": .iPhone5,
            "iPhone5,3": .iPhone5C,
            "iPhone5,4": .iPhone5C,
            "iPhone6,1": .iPhone5C,
            "iPhone6,2": .iPhone5C,
            "iPhone7,1": .iPhone6Plus,
            "iPhone7,2": .iPhone6,
            "iPhone8,1": .iPhone6s,
            "iPhone8,2": .iPhone6sPlus,
            "iPhone8,3": .iPhoneSE,
            "iPhone8,4": .iPhoneSE,
            "iPhone9,1": .iPhone7,
            "iPhone9,2": .iPhone7Plus,
            "iPhone9,3": .iPhone7,
            "iPhone9,4": .iPhone7Plus,
            "iPhone10,1": .iPhone8,
            "iPhone10,2": .iPhone8,
            "iPhone10,3": .iPhoneX,
            "iPhone10,4": .iPhone8,
            "iPhone10,5": .iPhone8,
            "iPhone10,6": .iPhoneX,
            "iPhone11,2": .iPhoneXS,
            "iPhone11,4": .iPhoneXSMax,
            "iPhone11,6": .iPhoneXSMax,
            "iPhone11,8": .iPhoneXR,
            
            /// iPod
            "iPod1,1": .iPod1,
            "iPod2,1": .iPod2,
            "iPod3,1": .iPod3,
            "iPod4,1": .iPod4,
            "iPod5,1": .iPod5,
            "iPod7,1": .iPod5,
            
            /// iPad
            "iPad2,1": .iPad2,
            "iPad2,2": .iPad2,
            "iPad2,3": .iPad2,
            "iPad2,4": .iPad2,
            "iPad3,1": .iPad3,
            "iPad3,2": .iPad3,
            "iPad3,3": .iPad3,
            "iPad2,5": .iPadMini1,
            "iPad2,6": .iPadMini1,
            "iPad2,7": .iPadMini1,
            "iPad3,4": .iPad4,
            "iPad3,5": .iPad4,
            "iPad3,6": .iPad4,
            "iPad4,1": .iPadAir1,
            "iPad4,2": .iPadAir1,
            "iPad4,3": .iPadAir1,
            "iPad4,4": .iPadMini2,
            "iPad4,5": .iPadMini2,
            "iPad4,6": .iPadMini2,
            "iPad4,7": .iPadMini3,
            "iPad4,8": .iPadMini3,
            "iPad4,9": .iPadMini3,
            "iPad5,1": .iPadMini4,
            "iPad5,2": .iPadMini4,
            "iPad5,3": .iPadAir2,
            "iPad5,4": .iPadAir2,
            "iPad6,3": .iPadPro9_7,
            "iPad6,4": .iPadPro9_7,
            "iPad6,7": .iPadPro12_9,
            "iPad6,8": .iPadPro12_9,
            "iPad6,11": .iPad5,
            "iPad6,12": .iPad5,
            "iPad7,1": .iPadPro12_9,
            "iPad7,2": .iPadPro12_9,
            "iPad7,3": .iPadPro10_5,
            "iPad7,4": .iPadPro10_5,
            "iPad7,5": .iPad6,
            "iPad7,6": .iPad6,
            "iPad8,1": .iPadPro11,
            "iPad8,2": .iPadPro11,
            "iPad8,3": .iPadPro11,
            "iPad8,4": .iPadPro11,
            "iPad8,5": .iPadPro12_9,
            "iPad8,6": .iPadPro12_9,
            "iPad8,7": .iPadPro12_9,
            "iPad8,8": .iPadPro12_9
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            return model
        }
        
        return Model.unrecognized
    }
    
}
