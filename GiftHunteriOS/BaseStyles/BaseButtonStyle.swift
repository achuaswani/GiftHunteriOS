//
//  ButtonStyle.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/5/20.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {
    var color: Color = Color.accentColor //#00BFAF for accent
    var halfScreen: Bool = false

    func makeBody(configuration: BaseButtonStyle.Configuration) -> some View {
        return configuration.label
            .foregroundColor(.white)
            .frame(width: halfScreen ? BaseStyle.buttonhalfWidth: BaseStyle.buttonFullWidth, height: 15)
            .padding(.all, BaseStyle.outerSpacing)
            .background(color)
            .cornerRadius(BaseStyle.cornerRadius)
            .shadow(radius: 10.0, x: 5, y: 5)
            .font(BaseStyle.normalFont)
    }
}
