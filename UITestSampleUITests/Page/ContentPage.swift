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
    
    var favoriteButton: XCUIElement { app.buttons["ContentView.FavoriteButton"] }
    var favoriteText: XCUIElement { app.staticTexts["ContentView.FavoriteText"] }
    var starButton: XCUIElement { app.buttons["ContentView.StarButton"] }
    var starText: XCUIElement { app.staticTexts["ContentView.StarText"] }
    var presentationButton: XCUIElement { app.buttons["ContentView.PresentationButton"] }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func visit() -> ContentPage {
        app.launch()
        return self
    }
}
