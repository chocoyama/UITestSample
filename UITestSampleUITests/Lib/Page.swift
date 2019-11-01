//
//  Page.swift
//  UITestSampleUITests
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import XCTest

protocol Page {
    var app: XCUIApplication { get }
    init(app: XCUIApplication)
    
    /// Describes the procedure for transitioning to the target screen
    @discardableResult func visit() -> Self
}

extension Page {
    @discardableResult
    func tap(
        _ keyPath: KeyPath<Self, XCUIElement>,
        count: Int = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let element = self[keyPath: keyPath].failIfNotExists(file: file, line: line)
        (0..<count).forEach { _ in element.tap() }
        return self
    }
    
    @discardableResult
    func type(
        text: String,
        for keyPath: KeyPath<Self, XCUIElement>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        self[keyPath: keyPath]
            .failIfNotExists(file: file, line: line)
            .typeText(text)
        return self
    }
    
    @discardableResult
    func swipeUp(
        _ keyPath: KeyPath<Self, XCUIElement>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        self[keyPath: keyPath]
            .failIfNotExists(file: file, line: line)
            .swipeUp()
        return self
    }
    
    @discardableResult
    func swipeDown(
        _ keyPath: KeyPath<Self, XCUIElement>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        self[keyPath: keyPath]
            .failIfNotExists(file: file, line: line)
            .swipeDown()
        return self
    }
    
    @discardableResult
    func swipeRight(
        _ keyPath: KeyPath<Self, XCUIElement>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        self[keyPath: keyPath]
            .failIfNotExists(file: file, line: line)
            .swipeRight()
        return self
    }
    
    @discardableResult
    func swipeLeft(
        _ keyPath: KeyPath<Self, XCUIElement>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        self[keyPath: keyPath]
            .failIfNotExists(file: file, line: line)
            .swipeLeft()
        return self
    }
}

extension Page {
    @discardableResult
    func waitForExistence(_ keyPath: KeyPath<Self, XCUIElement>, timeout: TimeInterval = 3.0) -> Self {
        let _ = self[keyPath: keyPath].waitForExistence(timeout: timeout)
        return self
    }
    
    @discardableResult
    func waitForHittable(_ keyPath: KeyPath<Self, XCUIElement>, timeout: TimeInterval = 3.0) -> Self {
        let expectation = XCTKVOExpectation(keyPath: "isHittable",
                                            object: self[keyPath: keyPath],
                                            expectedValue: true)
        let _ = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return self
    }
    
    @discardableResult
    func wait(for description: String, timeout: TimeInterval) -> Self {
        let expectation = XCTestExpectation(description: description)
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            expectation.fulfill()
        }
        XCTWaiter().wait(for: [expectation], timeout: timeout + 1)
        return self
    }
    
    @discardableResult
    func then(_ assertionHandler: (Self) -> Void) -> Self {
        assertionHandler(self)
        return self
    }
    
    @discardableResult
    func thenTransitionAndReturn<T: Page>(_ nextPageHandler: (T) -> Void) -> Self {
        let nextPage = T.init(app: self.app)
        nextPageHandler(nextPage)
        return self
    }
    
    @discardableResult
    func thenTransitionTo<T: Page>(_ type: T.Type) -> T {
        T.init(app: self.app)
    }
    
    @discardableResult
    func thenTransitionTo<T: Page>(_ nextPageHandler: (T) -> Void) -> T {
        let nextPage = T.init(app: self.app)
        nextPageHandler(nextPage)
        return nextPage
    }
}

extension Page {
    @discardableResult
    func screenshot(context testCase: XCTestCase, name: String? = nil, lifetime: XCTAttachment.Lifetime = .keepAlways) -> Self {
        let screenshot = XCUIApplication().screenshot()
        let attachment = XCTAttachment(uniformTypeIdentifier: "public.png",
                                       name: "\(name ?? testCase.name).png",
                                       payload: screenshot.pngRepresentation,
                                       userInfo: nil)
        attachment.lifetime = lifetime
        testCase.add(attachment)
        return self
    }
}

struct Scenario {
    init(_ title: String = "")  {}
    
    @discardableResult
    func scene<T: Page>(_ title: String, _ handler: () -> T) -> T {
        handler()
    }
}

extension Page {
    @discardableResult
    func scene<T: Page>(_ title: String, _ handler: (Self) -> T) -> T {
        handler(self)
    }
}

private extension XCUIElement {
    @discardableResult
    func failIfNotExists(file: StaticString, line: UInt) -> Self {
        if !exists {
            XCTFail("\(description) not exists.", file: file, line: line)
        }
        return self
    }
}
