//
//  UserResultsViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/13/20.
//

import SwiftUI

class UserResultsViewModel: ObservableObject {
    var viewRouter: ViewRouter
    var noQuizResultText = ""
    let headerTitle: String = "user.result.header.title".localized()
    var role: Role
    @Published var userResults = [UserResult]()
    @Published var showProgressView = false
    private let firebaseDataService: FirebaseDataService
    private let dataService = QuizService()

    init(viewRouter: ViewRouter, firebaseDataService: FirebaseDataService) {
        self.viewRouter = viewRouter
        self.firebaseDataService = firebaseDataService
        self.role = firebaseDataService.profile?.role ?? .user
    }
    
    func fetchAllAttendedQuizzes() {
        showProgressView = true
        let group = DispatchGroup()
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        var userResultsData = [UserResult]()
        guard let profile = firebaseDataService.profile,
              let pinSet = profile.quizPIN,
              !pinSet.isEmpty else {
            debugPrint("No quiz available")
            showProgressView = false
            return
        }
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }

            for pin in pinSet {
                group.enter()
                self.dataService.getActiveQuiz(for: pin) { quizModel in
                    if let quizModel = quizModel {
                        var userResult = UserResult(
                            pin: pin,
                            userName: profile.userName,
                            score: 0,
                            quizDetails: quizModel
                        )
                        if self.role == .user {
                            group.enter()
                            self.dataService.fetchScoreOfUser(
                                userName: profile.userName,
                                scoreBoardId: quizModel.scoreBoardId
                            ) { score in
                                    if let score = score {
                                        userResult.score = score
                                        userResultsData.append(userResult)
                                    }
                                    group.leave()
                                }
                        } else {
                            userResultsData.append(userResult)
                        }
                    }
                    group.leave()
                }
            }
            group.notify(queue: DispatchQueue.global()) {
                async { [weak self] in
                    self?.showProgressView = false
                    self?.userResults = userResultsData
                    self?.noQuizResultText = "user.result.no.results.text".localized()
                }
            }
        }
    }
    
    func getScoreBoard(_ scoreBoardId: String) {
        self.viewRouter.scoreBoardId = scoreBoardId
        routeToNextPage()
    }
    
    func routeToNextPage() {
        guard let nextPage = self.viewRouter.nextPage else {
            return
        }
        self.viewRouter.currentPage = nextPage
        
    }
}
