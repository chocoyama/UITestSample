//
//  ContentPage.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest
@testable import UITestSample

struct ContentPage: Page {
    var app: XCUIApplication
    
    var favoriteText: XCUIElement { app.staticTexts["ContentView.FavoriteText"] }
    var starText: XCUIElement { app.staticTexts["ContentView.StarText"] }
    private var favoriteButton: XCUIElement { app.buttons["ContentView.FavoriteButton"] }
    private var starButton: XCUIElement { app.buttons["ContentView.StarButton"] }
    private var presentationButton: XCUIElement { app.buttons["ContentView.PresentationButton"] }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func incrementFavorite(count: Int) -> Self {
        let _ = favoriteButton.waitForExistence(timeout: 3.0)
        (0..<count).forEach { _ in self.favoriteButton.tap() }
        return self
    }
    
    @discardableResult
    func incrementStar(count: Int) -> Self {
        let _ = starButton.waitForExistence(timeout: 3.0)
        (0..<count).forEach { _ in self.starButton.tap() }
        return self
    }
    
    @discardableResult
    func visitList() -> ListPage {
        presentationButton.tap()
        return ListPage(app: app)
    }
    
    func visit() -> ContentPage {
        app.launch()
        return self
    }
}
