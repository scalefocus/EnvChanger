//
//  EnvChanger_ExampleUITests.swift
//  EnvChanger_ExampleUITests
//
//  Created by Nikola B Nikolov on 29.11.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest

class EnvChanger_ExampleUITests: XCTestCase {
    
    // MARK: - Properties
    var app: XCUIApplication!
    var envButton: XCUIElement { app.buttons["ENV"] }
    var environmentChangedAlert: XCUIElement { app.alerts["Environment successfully changed."] }
    var closeEnvChangedAlertButton: XCUIElement { environmentChangedAlert.scrollViews.otherElements.buttons["Great!"] }
    
    // MARK: - Setup methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    // MARK: - Testing methods
    func testEnvButtonShowsEnvironmentOptions() {
        // given
        let selectProductionButton = app.sheets.firstMatch.scrollViews.otherElements.buttons["https://production.server.com/"]
        let selectStagingButton = app.sheets.firstMatch.scrollViews.otherElements.buttons["https://staging.server.com/"]
        let selectDevelopmentButton = app.sheets.firstMatch.scrollViews.otherElements.buttons["https://development.server.com"]
        let selectTestingButton = app.sheets.firstMatch.scrollViews.otherElements.buttons["https://10.0.1.1/"]
        let selectEdgeButton = app.sheets.firstMatch.scrollViews.otherElements.buttons["edge.server.com"]
        
        // when
        envButton.tap()
        
        // then
        XCTAssertTrue(selectProductionButton.exists)
        XCTAssertTrue(selectStagingButton.exists)
        XCTAssertTrue(selectDevelopmentButton.exists)
        XCTAssertTrue(selectTestingButton.exists)
        XCTAssertTrue(selectEdgeButton.exists)
    }
    
    func testEnvButtonDoesNotShowSuccessAlert() {
        // when
        envButton.tap()
        
        // then
        XCTAssertFalse(environmentChangedAlert.exists)
        XCTAssertFalse(closeEnvChangedAlertButton.exists)
    }
    
    func testSelectingEnvShowsSuccessAlert() {
        // when
        envButton.tap()
        app.sheets.firstMatch.scrollViews.otherElements.buttons.firstMatch.tap()
        
        // then
        XCTAssertTrue(environmentChangedAlert.waitForExistence(timeout: 1))
        XCTAssertTrue(closeEnvChangedAlertButton.exists)
    }
}
