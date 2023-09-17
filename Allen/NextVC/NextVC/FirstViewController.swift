//
//  FirstViewController.swift
//  NextVC
//
//  Created by Jeongwan Kim on 2023/09/17.
//

import UIKit

final class FirstViewController: UIViewController {
    
    var someString: String?
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = someString
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let backButton: UIButton = {
       let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    private func makeUI() {
        view.backgroundColor = UIColor.gray
        
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            backButton.widthAnchor.constraint(equalToConstant: 70),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
