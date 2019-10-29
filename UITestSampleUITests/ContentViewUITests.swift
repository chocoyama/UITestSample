//
//  ContentViewUITests.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

class ContentViewUITests: XCTestCase {
    
    var contentPage: ContentPage!

    override func setUp() {
        continueAfterFailure = true
        contentPage = ContentPage(app: XCUIApplication())
    }
    
    func testPlain() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["ContentView.FavoriteButton"].tap()
        XCTAssertEqual(app.staticTexts["ContentView.FavoriteText"].label, "1")
        
        let starButton = app.buttons["ContentView.StarButton"]
        starButton.tap()
        starButton.tap()
        starButton.tap()
        XCTAssertEqual(app.staticTexts["ContentView.StarText"].label, "3")
        
        var screenshot = XCUIScreen.main.screenshot()
        var attachment = XCTAttachment(uniformTypeIdentifier: "public.png",
                                       name: "ContentView.png",
                                       payload: screenshot.pngRepresentation,
                                       userInfo: nil)
        attachment.lifetime = .keepAlways
        add(attachment)
        
        app.buttons["ContentView.PresentationButton"].tap()
        XCTAssertTrue(app.staticTexts["PresentationView.Text"].waitForExistence(timeout: 3.0))
        
        screenshot = XCUIScreen.main.screenshot()
        attachment = XCTAttachment(uniformTypeIdentifier: "public.png",
                                   name: "PresentationView.png",
                                   payload: screenshot.pngRepresentation,
                                   userInfo: nil)
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testPageObject() {
        contentPage
            .visit()
            .tap(\.favoriteButton).then { XCTAssertEqual($0.favoriteText.label, "1") }
            .tap(\.starButton, count: 3).then { XCTAssertEqual($0.starText.label, "3") }
            .screenshot(context: self, name: "ContentView")
            .tap(\.presentationButton).thenTransitionTo { (presentationPage: PresentationPage) in
                presentationPage.then { XCTAssertTrue($0.label.waitForExistence(timeout: 3.0)) }
                    .screenshot(context: self, name: "PresentationView")
            }
    }
    
    func testScenario() {
        Scenario("ボタンをタップして遷移する")
            .start("ContentView") {
                contentPage
                    .visit()
                    .tap(\.favoriteButton).then { XCTAssertEqual($0.favoriteText.label, "1") }
                    .tap(\.starButton, count: 3).then { XCTAssertEqual($0.starText.label, "3") }
                    .screenshot(context: self, name: "ContentView")
                    .tap(\.presentationButton).thenTransitionTo(PresentationPage.self)
            }
            .then("PresentationView") { (presentationPage: PresentationPage) in
                presentationPage.then { XCTAssertTrue($0.label.waitForExistence(timeout: 3.0)) }
                    .screenshot(context: self, name: "PresentationView")
            }
    }
}
