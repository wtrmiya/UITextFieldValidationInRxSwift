//
//  Validation.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/03.
//

import Foundation

final class Validation {
    static func isAllUppercase(_ input: String) -> Bool {
        guard input.count > 0 else { return false }
        return input == input.uppercased()
    }
    
    static func isAllLowercase(_ input: String) -> Bool {
        guard input.count > 0 else { return false }
        return input == input.lowercased()
    }
    
    static func isNumberOnly(_ input: String) -> Bool {
        guard input.count > 0 else { return false }
        let expression = "^[0-9]+$"
        return matchStringFormat(matchedStr: input, withRegex: expression)
    }
    
    static private func matchStringFormat(matchedStr: String, withRegex expression: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: expression) else { return false }
        let checkingResults = regex.matches(in: matchedStr, range: NSRange(location: 0, length: matchedStr.count))
        return checkingResults.count > 0
    }
}
