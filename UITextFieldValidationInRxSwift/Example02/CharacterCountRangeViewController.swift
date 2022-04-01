//
//  CharacterCountRangeViewController.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/02.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift
import RxCocoa


final class CharacterCountRangeViewController:UIViewController {
    private let myTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "input words"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let myButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("init", for: .normal)
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
    
    private var viewModel:CharacterCountRangeViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = CharacterCountRangeViewModel()
        
        let input = CharacterCountRangeViewModel.Input(
            inputText: myTextField.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.isValid
            .drive(myButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(myTextField)
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6),
            myTextField.heightAnchor.constraint(equalToConstant: 44),
            myTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.addSubview(myButton)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.topAnchor.constraint(equalTo: myTextField.bottomAnchor, constant: 50),
        ])
    }
}

struct CharacterCountRangeViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CharacterCountRangeViewController()
        }
        .previewDevice("iPhone 13 mini")
    }
}

