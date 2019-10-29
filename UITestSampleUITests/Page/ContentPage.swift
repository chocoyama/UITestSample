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
    
    var button1: XCUIElement { app.getButtonBy(id: .contentViewButton1) }
    var button2: XCUIElement { app.getButtonBy(id: .contentViewButton2) }
    var text1: XCUIElement { app.getStaticTextBy(id: .contentViewLabel) }
    var presentationButton: XCUIElement { app.getButtonBy(id: .contentViewPresentationButton) }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func visit() -> ContentPage {
        app.launch()
        return self
    }
}
