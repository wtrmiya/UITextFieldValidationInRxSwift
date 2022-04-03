//
//  MultipluTextFieldsViewModelTest.swift
//  UITextFieldValidationInRxSwiftTests
//
//  Created by Wataru Miyakoshi on 2022/04/03.
//

import XCTest
@testable import UITextFieldValidationInRxSwift
import RxSwift
import RxCocoa
import RxTest

class MultipluTextFieldsViewModelTest: XCTestCase {
    private var viewModel:MultipluTextFieldsViewModel!
    private var scheduler:TestScheduler!
    private var disposeBag:DisposeBag!
    
    override func setUp() {
        viewModel = MultipluTextFieldsViewModel()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.1)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    private func createViewModelInput(
         firstText: Observable<String>? = nil,
         secondText: Observable<String>? = nil
    ) -> MultipluTextFieldsViewModel.Input {
        return MultipluTextFieldsViewModel.Input(
            firstText: firstText ?? PublishSubject<String>().asObservable(),
            secondText: secondText ?? PublishSubject<String>().asObservable()
        )
    }
    
    
    func testViewModel() {
        // ダミーのオブザーバをTestScheduler.createObserverで作成する。
        let outputBool = scheduler.createObserver(Bool.self)
        
        // inputを作成する。
        let inputs = MultipluTextFieldsViewModel.Input(
            firstText: scheduler.createColdObservable([
                .next(10, ""),
                .next(30, "abc"),
            ]).asObservable(),
            secondText: scheduler.createColdObservable([
                .next(20, ""),
                .next(40, "def"),
            ])
                .asObservable()// Cold / HotなTestableObservableを普通のObservableに変換してViewModelに渡す。
        )
        
        let outputs = viewModel.transform(input: inputs)
        
        outputs
            .resultBool
            .debug()
            .drive(outputBool)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(outputBool.events, [
            .next(20, false),
            .next(30, false),
            .next(40, true),
        ])
    }
    
}

