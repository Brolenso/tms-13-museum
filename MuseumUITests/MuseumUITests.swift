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

    }

    func testLoginEmailShown() throws {
        let app = XCUIApplication()
        app.launch()

        // filling login info
        app.otherElements["login-text-field"].tap()
        app.otherElements["login-text-field"].typeText("test@test.com")
        app.otherElements["password-text-field"].tap()
        app.otherElements["password-text-field"].typeText("test")

        // login
        app.buttons["login-button"].tap()

        // uppercase email must be shown
        XCTAssertTrue(app.scrollViews.otherElements.staticTexts["TEST@TEST.COM"].exists)
    }

    func testLaunchPerformance() throws {
        // measures how long launches app
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

}
