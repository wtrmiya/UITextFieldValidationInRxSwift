//
//  ValidationTest.swift
//  UITextFieldValidationInRxSwiftTests
//
//  Created by Wataru Miyakoshi on 2022/04/03.
//

import XCTest
@testable import UITextFieldValidationInRxSwift

class ValidationTest: XCTestCase {
    
    func testUppercaseOnly() {
        XCTContext.runActivity(named: "大文字のみ") { _ in
            let challengeText = "ABCDE"
            XCTAssertTrue(Validation.isAllUppercase(challengeText))
        }
        
        XCTContext.runActivity(named: "小文字あり") { _ in
            let challengeText = "aBCDE"
            XCTAssertFalse(Validation.isAllUppercase(challengeText))
        }
        
        XCTContext.runActivity(named: "空文字は失敗") { _ in
            let challengeText = ""
            XCTAssertFalse(Validation.isAllUppercase(challengeText))
        }
    }
    
    func testLowercaseOnly() {
        XCTContext.runActivity(named: "子文字のみ") { _ in
            let challengeText = "abcde"
            XCTAssertTrue(Validation.isAllLowercase(challengeText))
        }
        
        XCTContext.runActivity(named: "大文字あり") { _ in
            let challengeText = "Abcde"
            XCTAssertFalse(Validation.isAllLowercase(challengeText))
        }
        XCTContext.runActivity(named: "空文字は失敗") { _ in
            let challengeText = ""
            XCTAssertFalse(Validation.isAllUppercase(challengeText))
        }
    }
    
    func testNumberOnly() {
        XCTContext.runActivity(named: "数値のみ") { _ in
            let challengeText = "12345"
            XCTAssertTrue(Validation.isNumberOnly(challengeText))
        }
        
        XCTContext.runActivity(named: "全角数値ありは失敗すること") { _ in
            let challengeText = "１２３４５12345"
            XCTAssertFalse(Validation.isNumberOnly(challengeText))
        }
        XCTContext.runActivity(named: "空文字は失敗") { _ in
            let challengeText = ""
            XCTAssertFalse(Validation.isAllUppercase(challengeText))
        }
    }
}
