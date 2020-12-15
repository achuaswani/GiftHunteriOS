//
//  User.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

struct User {
    var uid: String
    var email: String?
    static let `default`  = Self(
        uid: "",
        email: ""
    )
}
