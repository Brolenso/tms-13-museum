//
//  MuseumUITests.swift
//  MuseumUITests
//
//  Created by Vyacheslav on 20.04.2023.
//

import XCTest

final class MuseumUITests: XCTestCase {

    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launch()
        
        // logout first
        let logoutButton = app.buttons["logout-button"]
        if logoutButton.exists {
            logoutButton.tap()
        }
        
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginEmailShown() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.otherElements["login-text-field"].tap()
        app.otherElements["login-text-field"].typeText("test@test.com")
        
        app.otherElements["password-text-field"].tap()
        app.otherElements["password-text-field"].typeText("test")

        app.buttons["login-button"].tap()
            
        XCTAssertTrue(app.scrollViews.otherElements.staticTexts["TEST@TEST.COM"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
