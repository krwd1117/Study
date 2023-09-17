//
//  FourthViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class FourthViewController: UIViewController {
    
    var someString: String?

    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = someString
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
