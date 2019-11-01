//
//  PresentationPage.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

struct ListPage: Page {
    var app: XCUIApplication
    
    var list: XCUIElement { app.tables["ListView.List"] }
    var thirdCell: XCUIElement { list.buttons["2"] }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func visit() -> ListPage {
        ContentPage(app: app)
            .visit()
            .tap(\.presentationButton)
        return self
    }
}
