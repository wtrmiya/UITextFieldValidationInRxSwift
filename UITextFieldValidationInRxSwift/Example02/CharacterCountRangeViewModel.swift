//
//  CharacterCountRangeViewModel.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/02.
//

import Foundation
import RxSwift
import RxCocoa

protocol CharacterCountRangeViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class CharacterCountRangeViewModel: CharacterCountRangeViewModelType {
    struct Input {
        // inputs (Observable)
        let inputText:Observable<String>
    }
    
    struct Output {
        // outputs (Driver, Binder, Observable)
        let isValid:Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        // 5文字以下ならValid
        let outputBool = input.inputText
            .debug()
            .map { $0.count >= 3 && $0.count <= 5 }
            .asDriver(onErrorJustReturn: false)
        
        return Output(isValid: outputBool)
    }
}

