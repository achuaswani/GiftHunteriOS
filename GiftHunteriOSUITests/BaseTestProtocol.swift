//
//  BaseTestProtocol.swift
//  GiftHunteriOSUITests
//
//  Created by Aswani on 10/21/20.
//

import XCTest

public protocol BaseTestProtocol {
    var app: XCUIApplication { get }
}

public extension BaseTestProtocol where Self: XCTestCase {
    func monitor() {
        addUIInterruptionMonitor(withDescription: "Alert") {
            (alert) -> Bool in
            print("interruption detected \(alert)")
            [("OK", 0),
             ("Allow", 2),
             ("Always allow", 0),
             ("Cancel", 0)
            ]
            .map { (alert.buttons[$0.0], $0.1)}
            .filter { $0.0.exists }
            .forEach { $0.0.tap(); sleep(UInt32($0.1)) }
            return true
        }
    }
    
    func launchApp() {
        app.launch()
    }
}
