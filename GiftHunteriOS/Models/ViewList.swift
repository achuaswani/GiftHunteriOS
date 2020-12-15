//
//  ViewList.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/12/20.
//

import Foundation

struct ViewList: Hashable {
    let currentPage: Page
    let nextPage: Page
    let buttonTitle: String
    let imageName: String
    static let `default` = Self(
        currentPage: .pinView,
        nextPage: .createQuizView,
        buttonTitle: "Title",
        imageName: "placeholder"
    )
}
