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
                    .assertExists(\.label)
                    .screenshot("PresentationPage", context: self)
            }
    }
}
