//
//  HomeDataView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/9/20.
//

import SwiftUI

struct HomeDataView: View {
    @ObservedObject var dataService: FirebaseDataService
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            VStack {
                DisplayPicture(profile: dataService.profile!)
                Divider()
                Text("Welcome \(dataService.profile!.displayName)")
                    .font(.headline)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Age: \(dataService.profile!.age)")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                Spacer()
                Text("About me: \(dataService.profile!.about)")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Class: \(dataService.profile!.grade)")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    .padding()
                Spacer()
            }
        }
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color.blue, radius: 20, x: 0, y: 10)
                
    }
    
}

struct HomeDataView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDataView(dataService: FirebaseDataService())
    }
}
