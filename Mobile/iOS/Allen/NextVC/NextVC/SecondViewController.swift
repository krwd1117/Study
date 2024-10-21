//
//  SecondViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    var someString: String?
    
    @IBOutlet private weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = someString
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}






