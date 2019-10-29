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
        
        app.buttons["ContentView.Button1"].tap()
        XCTAssertEqual(app.staticTexts["ContentView.Text"].label, "Tapped1")
        
        app.buttons["ContentView.Button2"].tap()
        XCTAssertEqual(app.staticTexts["ContentView.Text"].label, "Tapped2")
        
        app.buttons["ContentView.PresentationButton"].tap()
        XCTAssertTrue(app.staticTexts["PresentationView.Text"].waitForExistence(timeout: 3.0))
        
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(uniformTypeIdentifier: "public.png",
                                       name: "\(name).png",
                                       payload: screenshot.pngRepresentation,
                                       userInfo: nil)
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testPageObject() {
        contentPage
            .visit()
            .tap(\.button1).then { XCTAssertEqual($0.text1.label, "Tapped1") }
            .tap(\.button2).then { XCTAssertEqual($0.text1.label, "Tapped2") }
            .tap(\.presentationButton).thenTransitionTo { (presentationPage: PresentationPage) in
                presentationPage.then { XCTAssertTrue($0.label.waitForExistence(timeout: 3.0)) }
                    .screenshot(context: self)
            }
    }
    
    func testScenario() {
        Scenario("ボタンをタップして遷移する")
            .start("ContentView") {
                contentPage
                    .visit()
                    .tap(\.button1).then { XCTAssertEqual($0.text1.label, "Tapped1") }
                    .tap(\.button2).then { XCTAssertEqual($0.text1.label, "Tapped2") }
                    .tap(\.presentationButton).thenTransitionTo(PresentationPage.self)
            }
            .then("PresentationView") { (presentationPage: PresentationPage) in
                presentationPage.then { XCTAssertTrue($0.label.waitForExistence(timeout: 3.0)) }
                    .screenshot(context: self)
            }
    }
}
