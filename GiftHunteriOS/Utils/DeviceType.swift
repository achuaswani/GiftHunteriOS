//
//  DeviceType.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import UIKit

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
    static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
}

struct DeviceType {
    static let iPhone5orless = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength <= 568.0
    static let iPhone678orless = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength <= 667.0
    static let iPhone678porless = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength <= 736.0
    static let iPhoneXorless = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength <= 812.0
    static let iPad = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength >= 1080.0
}
