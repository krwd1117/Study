//
//  ViewController.swift
//  LoginProject
//
//  Created by Jeongwan Kim on 2023/09/16.
//

import UIKit

final class ViewController: UIViewController {
    
    private let loginView = LoginView()
    
    // viewDidLoad보다 우선 호출 됨 (view를 교체해줄 수 있음)
    override func loadView() {
        // 지금까진 ViewController의 기본 view를 사용했으나, View를 분리 했으므로 교체를 해줘야함
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Functions

extension ViewController {
    
    @objc func resetButtonTapped() {
        let alert = UIAlertController(
            title: "비밀번호 바꾸기",
            message: "비밀번호를 바꾸시겠습니까?",
            preferredStyle: .alert
        )
        let success = UIAlertAction(
            title: "확인",
            style: .default) { action in
                print("비밀번호를 바꿨습니다.")
            }
        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        alert.addAction(success)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
    @objc func loginButtonTapped() {
        print("로그인 버튼 눌림")
    }
}

