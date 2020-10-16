//
//  QuizView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var dataService: FirebaseDataService
    @State var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var questionNumber = 0
    @State var showingAlert = false
    
    var body: some View {
        VStack {
            content
        }
        .onAppear {
            dataService.fetchQuiz(grade: dataService.profile!.grade, level: "Level\(1)") { error in
                if error != nil {
                    showingAlert = true
                }
            }
        }
        .onDisappear {
            dataService.updateProfile(userValue: dataService.profile!) {_ in
                // TODO: show error if there is any
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("No Level available"),
                  message: Text("Come back later."),
                  dismissButton: .default(Text("Got it!")
                  ))
        }
    }
    
    var content: some View {
        VStack {
            if questionNumber == 10 {
                ZStack(alignment: .topTrailing) {
                    Text("Level completed. Click next for new Level")
                        .font(.system(size: 25, weight: .bold))
                    Spacer()
                    VStack {
                        Button(action: {
                            nextLevelAction()
                        }) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.normalButton)
                                .cornerRadius(15.0)
                                .shadow(radius: 10.0, x: 5, y: 5)

                        }
                        .padding()
                    }

                    .padding(.all, 5)
                }
            } else {
                HStack {
                    Text("\(timeRemaining)")
                        .onReceive(timer) { _ in
                            if self.timeRemaining > 0 {
                                self.timeRemaining -= 1
                            }
                        }
                    Text("Level: \(dataService.profile!.level)")
                    Text("Point: \(dataService.profile!.points)")
                }
                .padding()
                quizSetView
            }
        }
    }
    
    var quizSetView: some View {
        VStack(alignment: .center, spacing: 10.0) {
            Text(dataService.quizSet[questionNumber].question)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
                .padding()
            ForEach(0..<4) { index in
                Button(action: {
                    submitAnswer(index)
                }) {
                    Text(dataService.quizSet[questionNumber].options[index])
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 5, y: 5)

                }
                .padding()
            }
        }
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color.blue, radius: 20, x: 0, y: 10)
        .padding(.all)
    }
    
    func submitAnswer(_ index: Int) {
        if dataService.quizSet[questionNumber].answer == dataService.quizSet[questionNumber].options[index] {
            dataService.profile?.points += 1
        }
        questionNumber += 1
    }
    
    func nextLevelAction() {
        dataService.profile?.level += 1
        dataService.updateProfile(userValue: dataService.profile!) {_ in
            dataService.fetchQuiz(grade: dataService.profile!.grade,
                                  level: "Level\(dataService.profile!.level)") { error in
                if error == nil {
                    questionNumber = 0
                } else {
                    showingAlert = true
                }
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(dataService: FirebaseDataService())
    }
}
