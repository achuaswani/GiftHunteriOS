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
    
    func toast(isPresented: Binding<Bool>, text: Text) -> some View {
            Toast(isPresented: isPresented,
                  presenting: { self },
                  text: text)
        }
}

extension Color {
    static var normalTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
    
    static var normalButton: Color {
        return Color(red: 88.0/255.0, green: 199/255.0, blue: 199.0/255.0, opacity: 1.0)
    }
}
