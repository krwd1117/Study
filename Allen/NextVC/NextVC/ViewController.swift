//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        let firstVC = FirstViewController()
        firstVC.someString = "FirstVC"
        firstVC.modalPresentationStyle = .fullScreen
        present(firstVC, animated: true)
    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        // 스토리보드에서 secondVC에 해당하는 화면의 identity와 동일하게 맞춰줌
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        secondVC.someString = "SecondViewController"
        present(secondVC, animated: true)
    }
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        // 세그웨이를 활성화 시켜주는 코드
        performSegue(withIdentifier: "toThirdVC", sender: self)
    }
    
    // 3-1) 세그웨이로 화면을 이동할 때 데이터를 전달해주기 위해 재정의
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdVC" {
            let thirdVC = segue.destination as? ThirdViewController
            thirdVC?.someString = "ThirdVC"
        }
        
        // 4) 스토리보드에서 다음 화면을 가리키는 선에 identifier를 설정해줘야함
        if segue.identifier == "toFourthVC" {
            let fourthVC = segue.destination as? FourthViewController
            fourthVC?.someString = "FourthVC"
        }
    }
    
    // 직접 세그웨이일 때만 적용되는 함수
    // 조건에 따라 화면을 이동시킬지 결정 (버튼에서 직접적으로 세그웨이를 연결했을 때만 실행 됨)
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if true {
            return false
        } else {
            return true
        }
    }
    
}

