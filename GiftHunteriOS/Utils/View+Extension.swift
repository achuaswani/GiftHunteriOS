//
//  View+Extension.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

extension View {
    func debugPrint(_ value: Any) -> some View {
        #if DEBUG
        print(value)
        #endif
        return self
    }
    func toast(isPresented: Binding<Bool>, content: () -> Text) -> some View {
        Toast(isPresented: isPresented,
              presenting: { self },
              text: content())
    }
}
