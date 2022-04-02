//
//  Validation.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/03.
//

import Foundation

final class Validation {
    static func isAllUppercase(_ input: String) -> Bool {
        return input == input.uppercased()
    }
    
    static func isAllLowercase(_ input: String) -> Bool {
        return input == input.lowercased()
    }
}
