//
//  LoadingView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content
    var message: String

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 2 : 0)
                
                if isShowing {
                    Rectangle()
                        .fill(Color("loadingview")).opacity(isShowing ? 0.6 : 0)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 48) {
                        ProgressView().scaleEffect(2.0, anchor: .center)
                        Text(message).font(.title).fontWeight(.semibold)
                    }
                    .frame(width: 250, height: 200)
                    .background(Color.white)
                    .foregroundColor(Color.primary)
                    .cornerRadius(16)
                }
            }
        }
    }
}
