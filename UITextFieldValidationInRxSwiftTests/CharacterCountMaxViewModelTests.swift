//
//  CharacterCountMaxViewModelTests.swift
//  UITextFieldValidationInRxSwiftTests
//
//  Created by Wataru Miyakoshi on 2022/04/02.
//

import Foundation

import XCTest
@testable import UITextFieldValidationInRxSwift
import RxSwift
import RxCocoa
import RxTest

class CharacterCountMaxViewModelTests: XCTestCase {
    private var viewModel:CharacterCountMaxViewModel!
    private var scheduler:TestScheduler!
    private var disposeBag:DisposeBag!
    
    override func setUp() {
        viewModel = CharacterCountMaxViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testViewModel() {
        // ダミーのオブザーバをTestScheduler.createObserverで作成する。
        let outputBool = scheduler.createObserver(Bool.self)
        
        // inputを作成する。
        let inputs = CharacterCountMaxViewModel.Input(
            inputText: scheduler.createColdObservable([
                .next(10, ""),
                .next(20, "a"),
                .next(30, "ab"),
                .next(40, "abc"),
                .next(50, "abcd"),
                .next(60, "abcde"),
                .next(70, "abcdef"),
            ])
            .asObservable() // Cold / HotなTestableObservableを普通のObservableに変換してViewModelに渡す。
        )
        
        let outputs = viewModel.transform(input: inputs)
        
        outputs
            .isValid
            .drive(outputBool)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(outputBool.events, [
            .next(10, true),
            .next(20, true),
            .next(30, true),
            .next(40, true),
            .next(50, true),
            .next(60, true),
            .next(70, false),
        ])
    }
    
}

