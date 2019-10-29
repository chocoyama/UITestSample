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

    func testExample() {
        contentPage
            .visit()
            .tap(\.button1)
            .assert { (contentPage: ContentPage) in
                XCTAssertEqual(contentPage.text1.label, "Tapped1")
            }
            .tap(\.button2)
            .assert { (contentPage: ContentPage) in
                XCTAssertEqual(contentPage.text1.label, "Tapped2")
            }
            .tap(\.presentationButton)
            .transitionTo { (presentationPage: PresentationPage) in
                presentationPage
                    .assert { XCTAssertTrue($0.label.waitForExistence(timeout: 3.0)) }
                    .screenshot("PresentationPage", context: self)
            }
    }
    
    func testScenario() {
        Scenario("ボタンをタップして遷移する")
            .start("ContentView") {
                contentPage
                    .visit()
                    .tap(\.button1)
                    .assert { XCTAssertEqual($0.text1.label, "Tapped1") }
                    .tap(\.button2)
                    .assert { XCTAssertEqual($0.text1.label, "Tapped2") }
                    .tap(\.presentationButton)
                    .transitionTo(PresentationPage.self)
            }
            .then("PresentationView") { (presentationPage: PresentationPage) in
                presentationPage
                    .assert { XCTAssertTrue($0.label.waitForExistence(timeout: 3.0)) }
                    .screenshot("PresentationPage", context: self)
            }
    }
}
