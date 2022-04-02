//
//  CharacterTypeViewModelTest.swift
//  UITextFieldValidationInRxSwiftTests
//
//  Created by Wataru Miyakoshi on 2022/04/02.
//

import XCTest
@testable import UITextFieldValidationInRxSwift
import RxSwift
import RxCocoa
import RxTest

class CharacterTypeViewModelTest: XCTestCase {
    private var viewModel:CharacterTypeViewModel!
    private var scheduler:TestScheduler!
    private var disposeBag:DisposeBag!
    
    override func setUp() {
        viewModel = CharacterTypeViewModel()
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
        let inputs = CharacterTypeViewModel.Input(
            textToCheckUppercaseOnly:
                scheduler.createColdObservable([
                    .next(0, ""),
                    .next(10, "a"),
                    .next(20, "A"),
                    .next(30, "aB"),
                    .next(40, "AB"),
                ]).asObservable()
        )
        
        let outputs = viewModel.transform(input: inputs)
        
        outputs
            .isValidForUppercaseOnly
            .drive(outputBool)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(outputBool.events, [
            .next(0, false),
            .next(10, false),
            .next(20, true),
            .next(30, false),
            .next(40, true),
        ])
    }
    
}

