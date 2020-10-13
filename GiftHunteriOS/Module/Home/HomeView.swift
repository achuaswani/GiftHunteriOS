//
//  HomeView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var dataService = FirebaseDataService()
    
    @ViewBuilder
    var body: some View {
        VStack {
            content
        }
        .onAppear() {
            dataService.retrieveData()
        }
    }
    
    var content: some View {
        if let _ = dataService.profile {
            return AnyView(
                ZStack(alignment: .topTrailing){
                    VStack {
                        HomeDataView(dataService: dataService)
                        Spacer()
                        QuizStarter(dataService: dataService)
                    }
                    editAction
                    .padding(.all, 5)
                }
            )
        } else {
            return AnyView(
                    HomeNoDataView(dataService: dataService)
                )
        }
    }
    
    var editAction:  some View {
        NavigationLink(destination: ProfileView(dataService: dataService)) {
            Image(systemName: "pencil.circle.fill")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
