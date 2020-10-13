//
//  QuizStarter.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/10/20.
//

import SwiftUI

struct QuizStarter: View {
    @ObservedObject var dataService: FirebaseDataService
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Text("Level: \(dataService.profile!.level)")
                    .font(.headline)
                Text("Point: \(dataService.profile!.points)")
                    .font(.headline)
            }
        
            Spacer()
            VStack {
                NavigationLink(destination: QuizView(dataService: dataService)) {
                    Text("Start Quiz")
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
            Spacer()
        }
    }
}

struct QuizStarter_Previews: PreviewProvider {
    static var previews: some View {
        QuizStarter(dataService: FirebaseDataService())
    }
}
