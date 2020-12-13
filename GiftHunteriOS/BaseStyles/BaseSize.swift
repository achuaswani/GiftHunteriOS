//
//  BaseSize.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//
import SwiftUI

struct BaseSize {
    static var generalSpacing: CGFloat {
        if ScreenSize.maxLength > 812.0 {
            return 10
        } else {
            return 5
        }
    }
    
    static var outerSpacing: CGFloat {
        if ScreenSize.maxLength > 812.0 {
            return 15
        } else {
            return 10
        }
    }
}
