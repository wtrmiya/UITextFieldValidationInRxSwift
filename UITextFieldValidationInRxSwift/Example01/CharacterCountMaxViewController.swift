//
//  CharacterCountMaxViewController.swift
//  UITextFieldValidationInRxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/02.
//

import UIKit
import SwiftUI

final class CharacterCountMaxViewController: UIViewController {
    private let myTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "input words"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let myButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("init", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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

struct CharacterCountMaxViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CharacterCountMaxViewController()
        }
        .previewDevice("iPhone 13 mini")
    }
}

