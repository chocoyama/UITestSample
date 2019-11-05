//
//  ContentViewUITests.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

class ContentViewUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = true
    }
        
    func testUIRecording() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.staticTexts["ContentView.FavoriteText"].label, "0")
        app.buttons["ContentView.FavoriteButton"].tap()
        XCTAssertEqual(app.staticTexts["ContentView.FavoriteText"].label, "1")
        
        XCTAssertEqual(app.staticTexts["ContentView.StarText"].label, "0")
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
        ContentPage(app: .init())
            .visit().then {
                XCTAssertEqual($0.favoriteText.label, "0")
                XCTAssertEqual($0.starText.label, "0")
            }
            .incrementFavorite(count: 1).then { XCTAssertEqual($0.favoriteText.label, "1") }
            .incrementStar(count: 3).then { XCTAssertEqual($0.starText.label, "3") }
            .screenshot(context: self, name: "ContentView")
            .visitList().then { XCTAssertTrue($0.list.exists) }
            .screenshot(context: self, name: "ListView")
            .visitDetail().then { XCTAssertEqual($0.text.label, "2") }
            .screenshot(context: self, name: "DetailView")
    }
    
    func testScenario() {
        Scenario("アプリ起動から詳細画面への遷移まで").start(from: ContentPage(app: .init()))
            .scene("ContentViewが表示され、いいね数とスター数を変更する") { (contentPage: ContentPage) -> ContentPage in
                contentPage
                    .visit().then {
                        XCTAssertEqual($0.favoriteText.label, "0")
                        XCTAssertEqual($0.starText.label, "0")
                    }
                    .incrementFavorite(count: 1).then { XCTAssertEqual($0.favoriteText.label, "1") }
                    .incrementStar(count: 3).then { XCTAssertEqual($0.starText.label, "3") }
                    .screenshot(context: self, name: "ContentView")
            }
            .scene("ContentViewからListViewに遷移する") { (contentPage: ContentPage) -> ListPage in
                contentPage
                    .visitList().then { XCTAssertTrue($0.list.exists) }
                    .screenshot(context: self, name: "ListView")
            }
            .scene("ListViewからDetailViewに遷移する") { (listPage: ListPage) -> DetailPage in
                listPage
                    .visitDetail().then { XCTAssertEqual($0.text.label, "2") }
                    .screenshot(context: self, name: "DetailView")
            }
    }
}
