//
//  MultipluTextFieldsViewController.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/03.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

final class MultipluTextFieldsViewController: UIViewController {
    
     private let scrollView = UIScrollView()
     private let outlineView = UIView()
    
    private let firstTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "input words on first text field."
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let secondTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "input words on second text field."
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var resultButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("result", for: .normal)
        button.isEnabled = false
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var viewModel:MultipluTextFieldsViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOutlineView()
        
        setupUI()
        
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = MultipluTextFieldsViewModel()
        
        let input = MultipluTextFieldsViewModel.Input(
            firstText: firstTextField.rx.text.orEmpty.asObservable(),
            secondText: secondTextField.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.resultBool
            .drive(resultButton.rx.isEnabled)
            .disposed(by: bag)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        outlineView.addSubview(firstTextField)
        NSLayoutConstraint.activate([
            firstTextField.centerXAnchor.constraint(equalTo: outlineView.centerXAnchor),
            firstTextField.topAnchor.constraint(equalTo: outlineView.topAnchor, constant: 20),
            firstTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.9)
        ])
        
        outlineView.addSubview(secondTextField)
        NSLayoutConstraint.activate([
            secondTextField.centerXAnchor.constraint(equalTo: outlineView.centerXAnchor),
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20),
            secondTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.9)
        ])
        
        outlineView.addSubview(resultButton)
        NSLayoutConstraint.activate([
            resultButton.centerXAnchor.constraint(equalTo: outlineView.centerXAnchor),
            resultButton.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 100),
            resultButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.5)
        ])
    }
    
    
    private func setupOutlineView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        scrollView.addSubview(outlineView)
        outlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outlineView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            outlineView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            outlineView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            outlineView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            // 同じ大きさにする。
            outlineView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            outlineView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])
    }

}

struct PreviewViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            MultipluTextFieldsViewController()
        }
        .previewDevice("iPhone 13 mini")
    }
}

