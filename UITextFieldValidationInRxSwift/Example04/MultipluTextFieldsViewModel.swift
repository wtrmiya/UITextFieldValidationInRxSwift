//
//  MultipluTextFieldsViewModel.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/03.
//

import Foundation
import RxSwift
import RxCocoa

protocol MultipluTextFieldsViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class MultipluTextFieldsViewModel: MultipluTextFieldsViewModelType {
    struct Input {
        // inputs (Observable)
        let firstText: Observable<String>
        let secondText: Observable<String>
    }
    
    struct Output {
        // outputs (Driver, Binder, Observable)
        let resultBool: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let outputBool = Observable.combineLatest(input.firstText, input.secondText) { el1, el2 in
            print("check el1: \(el1), el2: \(el2)")
            return el1.count > 0 && el2.count > 0
        }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        return Output(resultBool: outputBool)
    }
}

