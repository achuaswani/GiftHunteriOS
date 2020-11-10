//
//  GiftHunteriOSUITests.swift
//  GiftHunteriOSUITests
//
//  Created by Aswani G on 8/6/20.
//

import XCTest

class GiftHunteriOSUITests: XCTestCase, BaseTestProtocol {
    let app = XCUIApplication()
    

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        launchApp()
        
        monitor()
        app.tap()
    }

    override func tearDown() {
        let screenshot = XCUIScreen.main.screenshot()
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
        fullScreenshotAttachment.lifetime = .deleteOnSuccess
        fullScreenshotAttachment.name = name
        add(fullScreenshotAttachment)
        app.terminate()
        super.tearDown()
    }    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                launchApp()
            }
        }
    }
}
