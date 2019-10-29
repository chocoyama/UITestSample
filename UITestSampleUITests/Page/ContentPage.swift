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
    
    var button1: XCUIElement { app.buttons["ContentView.Button1"] }
    var button2: XCUIElement { app.buttons["ContentView.Button2"] }
    var text1: XCUIElement { app.staticTexts["ContentView.Text"] }
    var presentationButton: XCUIElement { app.buttons["ContentView.PresentationButton"] }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func visit() -> ContentPage {
        app.launch()
        return self
    }
}
