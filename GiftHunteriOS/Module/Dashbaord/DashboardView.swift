//
//  DashboardView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct DashboardView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif

    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            TabBar()
                .navigationBarHidden(true)
        } else {
            Sidebar()
                .navigationBarHidden(true)
        }
        #else
        Sidebar()
            .frame(minWidth: 1000, minHeight: 600)
            .navigationBarHidden(true)
        #endif
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
