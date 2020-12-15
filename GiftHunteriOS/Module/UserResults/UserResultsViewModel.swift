//
//  UserResultsViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/13/20.
//

import SwiftUI

class UserResultsViewModel: ObservableObject {
    var viewRouter: ViewRouter
    let dataService = QuizService()
    let noQuizResultText = "user.result.no.results.text".localized()
    let headerTitle: String = "user.result.header.title".localized()
    @Published var userResults = [UserResult]()

    init(viewRouter: ViewRouter) {
        self.viewRouter = viewRouter
    }
    
    func fetchAllAttendedQuizes(profile: Profile?) {
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        var userResultsData = [UserResult]()
        guard let profile = profile,
              let pinSet = profile.quizPIN,
              !pinSet.isEmpty else {
            debugPrint("No quiz available")
            return
        }
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            group.enter()

            for pin in pinSet {
                self.dataService.verifyQuizPIN(pin: pin) { quizModel in
                    guard let quizModel = quizModel else {
                        return
                    }
                    let userResult = UserResult(
                        pin: pin,
                        userName: profile.userName,
                        score: 0,
                        quizDetails: quizModel
                    )
                    userResultsData.append(userResult)
                    group.leave()
                    semaphore.signal()
                }
            }
            semaphore.wait()
            group.enter()
            for i in 0..<userResultsData.count {
                self.dataService.fetchScoreOfUser(
                    userName: userResultsData[i].userName,
                    scoreBoardId: userResultsData[i].quizDetails.scoreBoardId) { score in
                        guard let score = score else {
                            return
                        }
                        userResultsData[i].score = score
                        group.leave()
                    }
            }
            group.notify(queue: DispatchQueue.global()) {
                async { [weak self] in
                    self?.userResults = userResultsData
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
