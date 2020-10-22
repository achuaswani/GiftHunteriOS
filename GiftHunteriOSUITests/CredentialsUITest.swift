//
//  CredentialsUITest.swift
//  GiftHunteriOSUITests
//
//  Created by Aswani on 10/16/20.
//

import XCTest

class CredentialsUITest: XCTestCase {
    private var app: XCUIApplication!
    override func setUp() {
        super.setUp()

        // Since UI tests are more expensive to run, it's usually
        // a good idea to exit if a failure was encountered
        continueAfterFailure = false

        app = XCUIApplication()

        // We send the uitesting command line argument to the app to
        // reset its state and to use the alert analytics engine
        app.launchArguments.append("--uitesting")
    }
    
    func testLoggingLoginScreenViewed() {
        app.launch()
        XCTAssertTrue(app.staticTexts["title"].exists)
        XCTAssertTrue(app.textFields["email"].exists)
        XCTAssertTrue(app.secureTextFields["password"].exists)
        XCTAssertTrue(app.buttons["button"].exists)
        loginAction()
    }
    
    func loginAction() {
        let emailIdTextField = app.textFields["email"]
        emailIdTextField.tap()
        emailIdTextField.typeText("Test@gmail.com \n")
        let passwordTextField = app.secureTextFields["password"]
        passwordTextField.doubleTap()        
        app.menuItems["Paste"].tap()
        let loginButton = app.buttons["button"]
        loginButton.tap()
        XCTAssertTrue(app.staticTexts["HomeView"].exists)
        
    }

}
