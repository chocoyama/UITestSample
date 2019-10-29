//
//  PresentationPage.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

struct PresentationPage: Page {
    var app: XCUIApplication
    
    var label: XCUIElement { app.getStaticTextBy(id: .presentationViewLabel) }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func visit() -> PresentationPage {
        ContentPage(app: app)
            .visit()
            .tap(\.presentationButton)
        return self
    }
}
