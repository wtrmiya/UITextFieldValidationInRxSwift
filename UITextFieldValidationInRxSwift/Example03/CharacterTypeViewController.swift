//
//  CharacterTypeViewController.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/02.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

final class CharacterTypeViewController:UIViewController {
    
    private let scrollView = UIScrollView()
    private let outlineView = UIView()
    
    private let forUpperCaseTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "input words in upper case"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let validLabelForUpperCase:UILabel = {
        let label = UILabel()
        label.text = "Valid."
        label.textColor = .green
        return label
    }()
    
    private let forLowerCaseTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "input words in upper case"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let validLabelForLowerCase:UILabel = {
        let label = UILabel()
        label.text = "Valid."
        label.textColor = .green
        return label
    }()
    
    private var viewModel:CharacterTypeViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOutlineView()
        
        setupUI()
        
        setupViewModel()
    }
    
    private func setupOutlineView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        scrollView.addSubview(outlineView)
        outlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outlineView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            outlineView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            outlineView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            outlineView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            // 縦スクロールにする。
            outlineView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            outlineView.heightAnchor.constraint(equalToConstant: 1000),
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // uppercase
        outlineView.addSubview(forUpperCaseTextField)
        outlineView.addSubview(validLabelForUpperCase)
        
        forUpperCaseTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forUpperCaseTextField.centerXAnchor.constraint(equalTo: outlineView.centerXAnchor),
            forUpperCaseTextField.topAnchor.constraint(equalTo: outlineView.topAnchor, constant: 100)
        ])
        
        validLabelForUpperCase.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            validLabelForUpperCase.topAnchor.constraint(equalTo: forUpperCaseTextField.bottomAnchor, constant: 20),
            validLabelForUpperCase.centerXAnchor.constraint(equalTo: outlineView.centerXAnchor),
        ])
        
        // lowercase
        outlineView.addSubview(forLowerCaseTextField)
        outlineView.addSubview(validLabelForLowerCase)
        
        forLowerCaseTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forLowerCaseTextField.centerXAnchor.constraint(equalTo: outlineView.centerXAnchor),
            forLowerCaseTextField.topAnchor.constraint(equalTo: forUpperCaseTextField.bottomAnchor, constant: 150)
        ])
        
        validLabelForLowerCase.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            validLabelForLowerCase.topAnchor.constraint(equalTo: forLowerCaseTextField.bottomAnchor, constant: 20),
            validLabelForLowerCase.centerXAnchor.constraint(equalTo: outlineView.centerXAnchor),
        ])
        
    }
    
    private func setupViewModel() {
        viewModel = CharacterTypeViewModel()
        
        let input = CharacterTypeViewModel.Input(
            textToCheckUppercaseOnly: forUpperCaseTextField.rx.text.orEmpty.asObservable(),
            textToCheckLowercaseOnly: forLowerCaseTextField.rx.text.orEmpty.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.isValidForUppercaseOnly
            .map { !$0 }
            .drive(validLabelForUpperCase.rx.isHidden)
            .disposed(by: bag)
        
        output.isValidForLowercaseOnly
            .map { !$0 }
            .drive(validLabelForLowerCase.rx.isHidden)
            .disposed(by: bag)
    }
}

struct CharacterTypeViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CharacterTypeViewController()
        }
        .previewDevice("iPhone 13 mini")
    }
}

