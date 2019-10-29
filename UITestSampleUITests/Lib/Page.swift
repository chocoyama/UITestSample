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
    
    /// 該当の画面へ遷移することができる手順を記述する
    @discardableResult func visit() -> Self
}

extension Page {
    @discardableResult
    func tap(_ keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath].tap()
        return self
    }
    
    @discardableResult
    func type(text: String, for keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath].typeText(text)
        return self
    }
    
    @discardableResult
    func swipeUp(_ keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath].swipeUp()
        return self
    }
    
    @discardableResult
    func swipeDown(_ keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath].swipeDown()
        return self
    }
    
    @discardableResult
    func swipeRight(_ keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath].swipeRight()
        return self
    }
    
    @discardableResult
    func swipeLeft(_ keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath].swipeLeft()
        return self
    }
}

extension Page {
    @discardableResult
    func assert(_ assertionHandler: (Self) -> Void) -> Self {
        assertionHandler(self)
        return self
    }
    
//    @discardableResult
//    func assertExists(_ keyPath: KeyPath<Self, XCUIElement>, timeout: TimeInterval = 3.0) -> Self {
//        XCTAssertTrue(self[keyPath: keyPath].waitForExistence(timeout: timeout))
//        return self
//    }
}

extension Page {
    @discardableResult
    func screenshot(_ name: String, context testCase: XCTestCase, lifetime: XCTAttachment.Lifetime = .keepAlways) -> Self {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(uniformTypeIdentifier: "public.png",
                                       name: "\(name).png",
                                       payload: screenshot.pngRepresentation,
                                       userInfo: nil)
        attachment.lifetime = lifetime
        testCase.add(attachment)
        return self
    }
    
    @discardableResult
    func transitionThenReturn<T: Page>(_ nextPageHandler: (T) -> Void) -> Self {
        let nextPage = T.init(app: self.app)
        nextPageHandler(nextPage)
        return self
    }
    
    @discardableResult
    func transitionTo<T: Page>(_ type: T.Type) -> T {
        T.init(app: self.app)
    }
    
    @discardableResult
    func transitionTo<T: Page>(_ nextPageHandler: (T) -> Void) -> T {
        let nextPage = T.init(app: self.app)
        nextPageHandler(nextPage)
        return nextPage
    }
    
    @discardableResult
    func wait(_ duration: TimeInterval) -> Self {
        let stopDate = Date().addingTimeInterval(duration)
        RunLoop.main.run(until: stopDate)
        return self
    }
    
}

struct Scenario {
    init(_ title: String)  {}
    
    @discardableResult
    func start<T>(_ title: String, _ handler: () -> T) -> T {
        handler()
    }
}

extension Page {
    @discardableResult
    func then<T>(_ title: String, _ handler: (Self) -> T) -> T {
        handler(self)
    }
}
