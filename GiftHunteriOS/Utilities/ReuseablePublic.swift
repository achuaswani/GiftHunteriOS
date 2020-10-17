//
//  ReuseablePublic.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/16/20.
//

import Foundation

func async(closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          closure()
     }
}
