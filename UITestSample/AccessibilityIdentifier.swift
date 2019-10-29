//
//  AccessibilityIdentifier.swift
//  UITestSample
//
//  Created by 横山 拓也 on 2019/10/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import Foundation
import SwiftUI

//protocol AccessibilityIdentifiable {
//    var value: String { get }
//}
//
//struct AccessibilityIdentifier {
//    struct Button: AccessibilityIdentifiable {
//        var value: String
//    }
//}
//
//extension View {
//    func accessibility(identifier: AccessibilityIdentifiable) -> some View {
//        accessibility(identifier: identifier.value)
//    }
//}
//
//extension AccessibilityIdentifier.Button {
//    static let contentViewButton1 = AccessibilityIdentifier.Button(value: "contentViewButton1")
//    static let contentViewButton2 = AccessibilityIdentifier.Button(value: "contentViewButton2")
//    static let contentViewPresentationButton = AccessibilityIdentifier.Button(value: "contentViewPresentationButton")
//}

struct AccessibilityIdentifier {
    let value: String
}

extension View {
    func accessibility(identifier: AccessibilityIdentifier) -> some View {
        accessibility(identifier: identifier.value)
    }
}

extension AccessibilityIdentifier {
    static let contentViewLabel = AccessibilityIdentifier(value: "contentViewLabel")
    static let contentViewButton1 = AccessibilityIdentifier(value: "contentViewButton1")
    static let contentViewButton2 = AccessibilityIdentifier(value: "contentViewButton2")
    static let contentViewPresentationButton = AccessibilityIdentifier(value: "contentViewPresentationButton")
    static let presentationViewLabel = AccessibilityIdentifier(value: "presentationViewLabel")
}
