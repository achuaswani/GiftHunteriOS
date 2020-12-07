//
//  User.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//
import Foundation

struct User {

    var uid: String
    var email: String?
    var displayName: String?
    var photoURL: URL?
    static let `default`  = Self(
        uid: "",
        email: "",
        displayName: "",
        photoURL: nil
    )
}
