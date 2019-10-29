//
//  XCUIApplication+.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

extension XCUIApplication {
    func buttons(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        buttons[accessibilityIdentifier.value]
    }
    
    func staticTexts(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        staticTexts[accessibilityIdentifier.value]
    }
    
    func otherElements(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        otherElements[accessibilityIdentifier.value]
    }
    
    func navigationBars(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        navigationBars[accessibilityIdentifier.value]
    }
    
    func tabBars(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        tabBars[accessibilityIdentifier.value]
    }
    
    func collectionViews(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        collectionViews[accessibilityIdentifier.value]
    }
    
    func textFields(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        textFields[accessibilityIdentifier.value]
    }
    
    func textViews(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        textViews[accessibilityIdentifier.value]
    }
    
    func tables(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        tables[accessibilityIdentifier.value]
    }
    
    func sheets(_ accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        sheets[accessibilityIdentifier.value]
    }
}
