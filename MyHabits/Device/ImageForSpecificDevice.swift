//
//  ImageForSpecificDevice.swift
//  MyHabits
//
//  Created by M M on 6/9/22.
//

import UIKit

public enum DeviceSpecific {
    case iPhone8
    case iPhone8Plus
    case iPhone11
    case iPhone11Pro
    case iPhone12
    case iPhone12ProMax
    case iPhone13
    case iPhone12Pro
    case iPad9Gen
    case iPadPro3Gen11
    case iPadPro3Gen12_9
    case iPadAir5Gen
    case Unknown
}

public extension UIImage {
    
    private class func currentDeviceSpecific() -> DeviceSpecific {
        
        let height = Float(UIScreen.main.bounds.size.height)
        let width = Float(UIScreen.main.bounds.size.width)
        let pixelDimension = Int(fmaxf(height, width))
        
        switch pixelDimension {
        case 667: return .iPhone8
        case 736: return .iPhone8Plus
        case 812: return .iPhone11Pro
        case 844: return .iPhone12Pro
        case 896: return .iPhone11
        case 926: return .iPhone12ProMax
        case 1080: return .iPad9Gen
        case 1194: return .iPadPro3Gen11
        case 1366: return .iPadPro3Gen12_9
        case 1640: return .iPadAir5Gen
            
        default: return .Unknown
        }
    }

    /*private class func suffixForDevice() -> String {
        switch currentDeviceSpecific() {

        }
    }*/
}
