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
    
    func testUIRecording() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.staticTexts["ContentView.FavoriteText"].label, "0")
        XCTAssertEqual(app.staticTexts["ContentView.StarText"].label, "0")
        
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
        XCTAssertTrue(app.tables["ListView.List"].waitForExistence(timeout: 3.0))
        
        screenshot = XCUIScreen.main.screenshot()
        attachment = XCTAttachment(uniformTypeIdentifier: "public.png",
                                   name: "ListView.png",
                                   payload: screenshot.pngRepresentation,
                                   userInfo: nil)
        attachment.lifetime = .keepAlways
        add(attachment)
        
        app.tables["ListView.List"].buttons["2"].tap()
        
        XCTAssertTrue(app.staticTexts["DetailView.Text"].waitForExistence(timeout: 3.0))
        XCTAssertEqual(app.staticTexts["DetailView.Text"].label, "2")
        
        screenshot = XCUIScreen.main.screenshot()
        attachment = XCTAttachment(uniformTypeIdentifier: "public.png",
                                   name: "DetailView.png",
                                   payload: screenshot.pngRepresentation,
                                   userInfo: nil)
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testPageObject() {
        contentPage
            .visit()
            .waitForExistence(\.favoriteText).then { XCTAssertEqual($0.favoriteText.label, "0") }
            .waitForExistence(\.starText).then { XCTAssertEqual($0.starText.label, "0") }
            .tap(\.favoriteButton).then { XCTAssertEqual($0.favoriteText.label, "1") }
            .tap(\.starButton, count: 3).then { XCTAssertEqual($0.starText.label, "3") }
            .screenshot(context: self, name: "ContentView")
            .tap(\.presentationButton).thenTransitionTo { (listPage: ListPage) in
                listPage.waitForExistence(\.list).then { XCTAssertTrue($0.list.exists) }
                    .screenshot(context: self, name: "ListView")
                    .tap(\.thirdCell).thenTransitionTo { (detailPage: DetailPage) in
                        detailPage.waitForExistence(\.text).then { XCTAssertEqual($0.text.label, "2") }
                            .screenshot(context: self, name: "DetailView")
                    }
            }
    }
    
    func testScenario() {
        Scenario("アプリ起動から詳細画面への遷移まで")
            .scene("ContentViewが表示される") {
                contentPage
                    .visit()
                    .waitForExistence(\.favoriteText).then { XCTAssertEqual($0.favoriteText.label, "0") }
                    .waitForExistence(\.starText).then { XCTAssertEqual($0.starText.label, "0") }
                    .tap(\.favoriteButton).then { XCTAssertEqual($0.favoriteText.label, "1") }
                    .tap(\.starButton, count: 3).then { XCTAssertEqual($0.starText.label, "3") }
                    .screenshot(context: self, name: "ContentView")
                    .tap(\.presentationButton).thenTransitionTo(ListPage.self)
            }
            .scene("ボタンをタップしてListViewに遷移後") { (listPage: ListPage) in
                listPage
                    .waitForExistence(\.list).then { XCTAssertTrue($0.list.exists) }
                    .screenshot(context: self, name: "ListView")
                    .tap(\.thirdCell).thenTransitionTo(DetailPage.self)
            }
            .scene("セルをタップしてDetailViewに遷移後") { (detailPage: DetailPage) in
                detailPage
                    .waitForExistence(\.text).then { XCTAssertEqual($0.text.label, "2") }
                    .screenshot(context: self, name: "DetailView")
            }
        
    }
}
