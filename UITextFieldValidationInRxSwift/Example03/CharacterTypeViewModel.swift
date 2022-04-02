//
//  CharacterTypeViewModel.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/02.
//

import Foundation
import RxSwift
import RxCocoa

protocol CharacterTypeViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class CharacterTypeViewModel: CharacterTypeViewModelType {
    struct Input {
        // inputs (Observable)
        let textToCheckUppercaseOnly: Observable<String>
        let textToCheckLowercaseOnly: Observable<String>
    }
    
    struct Output {
        // outputs (Driver, Binder, Observable)
        let isValidForUppercaseOnly: Driver<Bool>
        let isValidForLowercaseOnly: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let outputForUppercaseValidation = input.textToCheckUppercaseOnly
            .map(Validation.isAllUppercase)
            .asDriver(onErrorJustReturn: false)
        
        let outputForLowercaseValidation = input.textToCheckLowercaseOnly
            .map(Validation.isAllLowercase)
            .asDriver(onErrorJustReturn: false)
        
        return Output(
            isValidForUppercaseOnly: outputForUppercaseValidation,
            isValidForLowercaseOnly: outputForLowercaseValidation
        )
    }
}

