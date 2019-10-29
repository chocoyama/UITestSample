//
//  XCUIApplication+.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

extension XCUIApplication {
    func getButtonBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        buttons[accessibilityIdentifier.value]
    }
    
    func getStaticTextBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        staticTexts[accessibilityIdentifier.value]
    }
    
    func getOtherElementBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        otherElements[accessibilityIdentifier.value]
    }
    
    func getNavigationBarBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        navigationBars[accessibilityIdentifier.value]
    }
    
    func getTabBarsBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        tabBars[accessibilityIdentifier.value]
    }
    
    func getCollectionViewBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        collectionViews[accessibilityIdentifier.value]
    }
    
    func getTextFieldBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        textFields[accessibilityIdentifier.value]
    }
    
    func getTextViewBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        textViews[accessibilityIdentifier.value]
    }
    
    func getTableViewBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        tables[accessibilityIdentifier.value]
    }
    
    func getSheetBy(id accessibilityIdentifier: AccessibilityIdentifier) -> XCUIElement {
        sheets[accessibilityIdentifier.value]
    }
}
