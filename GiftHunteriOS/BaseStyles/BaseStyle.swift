//
//  BaseStyle.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//
import SwiftUI

struct BaseStyle {
    static var generalSpacing: CGFloat {
        if DeviceType.iPhone5orless {
            return 5
        } else if DeviceType.iPhone678orless {
            return 7
        } else {
            return 10
        }
    }
    
    static var innerSpacing: CGFloat {
        if DeviceType.iPhone5orless {
            return 10
        } else if DeviceType.iPhone678orless {
            return 12
        } else {
            return 15
        }
    }
    
    static var outerSpacing: CGFloat {
        if DeviceType.iPhone5orless {
            return 10
        } else if DeviceType.iPhone678orless {
            return 12
        } else {
            return 15
        }
    }

    static var headerFont: Font {
        if DeviceType.iPhone5orless {
            return .system(size: 24, weight: .bold, design: .rounded)
        } else if DeviceType.iPhone678orless {
            return .system(size: 32, weight: .bold, design: .rounded)
        } else {
            return .system(size: 42, weight: .bold, design: .rounded)
        }
    }
    
    static var normalFont: Font {
        if DeviceType.iPhone5orless {
            return .system(size: 14, weight: .bold, design: .rounded)
        } else if DeviceType.iPhone678orless {
            return .system(size: 15, weight: .bold, design: .rounded)
        } else {
            return .system(size: 16, weight: .bold, design: .rounded)
        }
    }
    
    static var cornerRadius: CGFloat {
        if DeviceType.iPhone5orless {
            return 10.0
        } else if DeviceType.iPhone678orless {
            return 15.0
        } else {
            return 20.0
        }
    }
}
