//
//  BaseTestClass.swift
//  GiftHunteriOSUITests
//
//  Created by Aswani on 10/21/20.
//

import XCTest

#if DEBUG
public let defaultElementWaitingTimeout: TimeInterval = 10
#else
public let defaultElementWaitingTimeout: TimeInterval = 20
#endif
public let defaultElementNotExistsWaitingTimeout: TimeInterval = 2 * defaultElementWaitingTimeout
class BaseTestClass: XCTestCase {
    private var app = XCUIApplication()
    public func waitForElementExist(_ element: XCUIElement?, _ timeout: Double = defaultElementWaitingTimeout) {
        if let element = element {
            if !doesElementExist(element as XCUIElement?, timeout: timeout) {
                XCTFail("\n\nELEMENT \(String(describing: element)) NOT FOUND!!!\n\n")
            }
        } else { print("### Element does not exist or not in datasources for current flavour!!!") }
    }
    
    public func doesElementExist(_ element: XCUIElement?, timeout: Double = defaultElementWaitingTimeout, _ format: String = "exists == true") -> Bool {
        guard let element = element else { print("Element does not exists in list")
            return false
        }
        let existsPredicate = NSPredicate(format: format)
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate,
                                                    object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }


}
