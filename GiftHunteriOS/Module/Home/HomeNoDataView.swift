//
//  HomeNoDataView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/9/20.
//

import SwiftUI

struct HomeNoDataView: View {
    @ObservedObject var dataService: FirebaseDataService
    
    var body: some View {
        VStack {
            NavigationLink(destination:
                            ProfileView(dataService: dataService)) {
                Text("Add Profile details to Begin")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.normalButton)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 5, y: 5)
            }
            .padding(.all)
        }
    }
}

struct HomeNoDataView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNoDataView(dataService: FirebaseDataService())
    }
}
