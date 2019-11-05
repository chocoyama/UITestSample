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
    init(_ title: String = "") {}
    
    @discardableResult
    func start<T: Page>(from page: T) -> T {
        page
    }
}

extension Page {
    @discardableResult
    func scene<T: Page>(_ title: String, _ handler: (Self) -> T) -> T {
        XCTContext.runActivity(named: title) { _ in
            return handler(self)
        }
    }
}
