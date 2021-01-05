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

      configuration.label
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .background(color)
        .cornerRadius(15.0)
        .shadow(radius: 10.0, x: 5, y: 5)

    }
}
