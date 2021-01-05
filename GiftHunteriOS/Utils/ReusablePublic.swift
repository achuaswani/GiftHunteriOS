//
//  ReuseablePublic.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/16/20.
//

import Foundation

func async(deadline: Double = 0.5, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
          closure()
     }
}
func async(closure: @escaping () -> Void) {
    DispatchQueue.main.async {
          closure()
     }
}
