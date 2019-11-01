//
//  DetailPage.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/30.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

struct DetailPage: Page {
    var app: XCUIApplication
    
    var text: XCUIElement { app.staticTexts["DetailView.Text"] }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func visit() -> DetailPage {
        ListPage(app: app)
            .visit()
            .tap(\.thirdCell)
        return self
    }
}

