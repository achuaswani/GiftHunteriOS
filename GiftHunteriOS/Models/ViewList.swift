//
//  ViewList.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/12/20.
//

import Foundation

struct ViewList: Hashable {
    let viewName: Page
    let buttonTitle: String
    let imageName: String
    static let `default` = Self(viewName: .pinView, buttonTitle: "Title", imageName: "placeholder")
}
