//
//  ButtonStyle.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/5/20.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {
    var color: Color = Color.accentColor //#00BFAF for accent

    func makeBody(configuration: BaseButtonStyle.Configuration) -> some View {
        if DeviceType.iPhone5orless {
            return configuration.label
                .foregroundColor(.white)
                .frame(width: 250, height: 15)
                .padding(.all, 12)
                .background(color)
                .cornerRadius(15.0)
                .shadow(radius: 10.0, x: 5, y: 5)
                .font(.system(size: 14, weight: .bold, design: .rounded))
        } else if DeviceType.iPhone678orless {
            return configuration.label
                .foregroundColor(.white)
                .frame(width: 280, height: 15)
                .padding(.all, 15)
                .background(color)
                .cornerRadius(15.0)
                .shadow(radius: 10.0, x: 5, y: 5)
                .font(.system(size: 15, weight: .bold, design: .rounded))
        } else {
            return configuration.label
                .foregroundColor(.white)
                .frame(width: 300, height: 15)
                .padding(.all, 20)
                .background(color)
                .cornerRadius(15.0)
                .shadow(radius: 10.0, x: 5, y: 5)
                .font(.system(size: 16, weight: .bold, design: .rounded))
        }

    }
}
