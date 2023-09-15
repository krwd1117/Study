//
//  ViewController.swift
//  TextFieldDelegate
//
//  Created by Jeongwan Kim on 2023/09/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.gray
        
        textField.placeholder = "이메일 주소 입력"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .go
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
        
        
    }
}

