//
//  ViewRouter.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

enum Page {
    case pinView
    case resultView
    case questionView
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .pinView
}
