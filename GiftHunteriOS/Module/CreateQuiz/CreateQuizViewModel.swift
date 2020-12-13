//
//  CreateQuizViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/12/20.
//

import SwiftUI

class CreateQuizViewModel: ObservableObject {
    var viewRouter: ViewRouter
    init(viewRouter: ViewRouter) {
        self.viewRouter = viewRouter
    }
}
