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
    }
    
    struct Output {
        // outputs (Driver, Binder, Observable)
        let isValidForUppercaseOnly: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let outputs = input.textToCheckUppercaseOnly
            .map { $0.count > 0 && $0 == $0.uppercased() }
            .asDriver(onErrorJustReturn: false)
        
        return Output(isValidForUppercaseOnly: outputs)
    }
}

