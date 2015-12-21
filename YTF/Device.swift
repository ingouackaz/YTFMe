//
//  Device.swift
//  imHome
//
//  Created by Kevin Xu on 2/9/15. Updated on 6/20/15.
//  Copyright (c) 2015 Alpha Labs, Inc. All rights reserved.
//

import Foundation

// MARK: - Device Structure

extension String
{
    func toDateTime() -> NSDate
    {
        //Create Date Formatter
        let dateFormatter = NSDateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.dateFromString(self)!
        
        //Return Parsed Date
        return dateFromString
    }
}

enum DeviceId : Int {
    
    case iPhone4 = 0, iPhone5 = 1, iPhone6 = 2, iPhone6Plus = 3
    
    static let allValues = [iPhone4, iPhone5, iPhone6, iPhone6Plus]
}

public extension UIDevice {
    
    enum DeviceId : Int {
        
        // case iPhone4 = "iPhone4", iPhone5 = "iPhone5", iPhone6 = "iPhone6", iPhone6Plus = "iPhone6Plus"
        case iPhone4 = 0, iPhone5 = 1, iPhone6 = 2, iPhone6Plus = 3
        
        static let allValues = [iPhone4, iPhone5, iPhone6, iPhone6Plus]
    }
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,1", "iPad5,3", "iPad5,4":           return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    var modelId : DeviceId {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return DeviceId.iPhone5
        case "iPod7,1":                                 return DeviceId.iPhone5
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return DeviceId.iPhone4
        case "iPhone4,1":                               return DeviceId.iPhone4
        case "iPhone5,1", "iPhone5,2":                  return DeviceId.iPhone5
        case "iPhone5,3", "iPhone5,4":                  return DeviceId.iPhone5
        case "iPhone6,1", "iPhone6,2":                  return DeviceId.iPhone5
        case "iPhone7,2":                               return DeviceId.iPhone6
        case "iPhone7,1":                               return DeviceId.iPhone6Plus
        case "iPhone8,1":                               return DeviceId.iPhone6
        case "iPhone8,2":                               return DeviceId.iPhone6Plus
        case "i386", "x86_64":
            
            if(Device.IS_3_5_INCHES()){
                return DeviceId.iPhone4
            }
            else if(Device.IS_4_INCHES()) {
                return DeviceId.iPhone5
            }
            else if(Device.IS_4_7_INCHES()) {
                return DeviceId.iPhone6
            }
            else {
                return DeviceId.iPhone6Plus
            }
            
        default:
            return DeviceId.iPhone5
        }
    }
    
    
    
}

struct Device {

    // MARK: - Singletons

    static var TheCurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.currentDevice()
        }
        return Singleton.device
    }

    static var TheCurrentDeviceVersion: Float {
        struct Singleton {
            static let version = Float(UIDevice.currentDevice().systemVersion)
        }
        return Singleton.version!
    }

    static var TheCurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.mainScreen().bounds.size.height
        }
        return Singleton.height
    }

    // MARK: - Device Idiom Checks

    static var PHONE_OR_PAD: String {
        if isPhone() {
            return "iPhone"
        } else if isPad() {
            return "iPad"
        }
        return "Not iPhone nor iPad"
    }

    static var DEBUG_OR_RELEASE: String {
        #if DEBUG
            return "Debug"
        #else
            return "Release"
        #endif
    }

    static var SIMULATOR_OR_DEVICE: String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return "Simulator"
        #else
            return "Device"
        #endif
    }


    static func isPhone() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .Phone
    }

    static func isPad() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .Pad
    }

    static func isDebug() -> Bool {
        return DEBUG_OR_RELEASE == "Debug"
    }

    static func isRelease() -> Bool {
        return DEBUG_OR_RELEASE == "Release"
    }

    static func isSimulator() -> Bool {
        return SIMULATOR_OR_DEVICE == "Simulator"
    }

    static func isDevice() -> Bool {
        return SIMULATOR_OR_DEVICE == "Device"
    }

    // MARK: - Device Version Checks

    enum Versions: Float {
        case Five = 5.0
        case Six = 6.0
        case Seven = 7.0
        case Eight = 8.0
        case Nine = 9.0
    }

    static func isVersion(version: Versions) -> Bool {
        return TheCurrentDeviceVersion >= version.rawValue && TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }

    static func isVersionOrLater(version: Versions) -> Bool {
        return TheCurrentDeviceVersion >= version.rawValue
    }

    static func isVersionOrEarlier(version: Versions) -> Bool {
        return TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }

    static var CURRENT_VERSION: String {
        return "\(TheCurrentDeviceVersion)"
    }

    // MARK: iOS 5 Checks

    static func IS_OS_5() -> Bool {
        return isVersion(.Five)
    }

    static func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.Five)
    }

    static func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Five)
    }

    // MARK: iOS 6 Checks

    static func IS_OS_6() -> Bool {
        return isVersion(.Six)
    }

    static func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.Six)
    }

    static func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Six)
    }

    // MARK: iOS 7 Checks

    static func IS_OS_7() -> Bool {
        return isVersion(.Seven)
    }

    static func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.Seven)
    }

    static func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Seven)
    }

    // MARK: iOS 8 Checks

    static func IS_OS_8() -> Bool {
        return isVersion(.Eight)
    }

    static func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.Eight)
    }

    static func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Eight)
    }

    // MARK: iOS 9 Checks

    static func IS_OS_9() -> Bool {
        return isVersion(.Nine)
    }

    static func IS_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(.Nine)
    }

    static func IS_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Nine)
    }

    // MARK: - Device Size Checks

    enum Heights: CGFloat {
        case Inches_3_5 = 480
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }

    static func isSize(height: Heights) -> Bool {
        return TheCurrentDeviceHeight == height.rawValue
    }

    static func isSizeOrLarger(height: Heights) -> Bool {
        return TheCurrentDeviceHeight >= height.rawValue
    }

    static func isSizeOrSmaller(height: Heights) -> Bool {
        return TheCurrentDeviceHeight <= height.rawValue
    }

    static var CURRENT_SIZE: String {
        if IS_3_5_INCHES() {
            return "3.5 Inches"
        } else if IS_4_INCHES() {
            return "4 Inches"
        } else if IS_4_7_INCHES() {
            return "4.7 Inches"
        } else if IS_5_5_INCHES() {
            return "5.5 Inches"
        }
        return "\(TheCurrentDeviceHeight) Points"
    }

    // MARK: Retina Check

    static func IS_RETINA() -> Bool {
        return UIScreen.mainScreen().respondsToSelector("scale")
    }

    // MARK: 3.5 Inch Checks

    static func IS_3_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_3_5)
    }

    static func IS_3_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_3_5)
    }

    static func IS_3_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_3_5)
    }

    // MARK: 4 Inch Checks

    static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4)
    }

    static func IS_4_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4)
    }

    static func IS_4_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_4)
    }

    // MARK: 4.7 Inch Checks

    static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4_7)
    }

    static func IS_4_7_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }

    static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }

    // MARK: 5.5 Inch Checks

    static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_5_5)
    }

    static func IS_5_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }

    static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }

    // MARK: - International Checks

    static var CURRENT_REGION: String {
        return NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
    }
}