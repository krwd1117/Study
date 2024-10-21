

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmi: BMI?
    var bmiManager = BMICalcualteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        makeUI()
    }
    
    private func makeUI() {
        mainLabel.text = "키와 몸무게를 입력해주세요."
        
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm단위로 입력해주세요."
        weightTextField.placeholder = "kg단위로 입력해주세요."
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) { }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.bmi = bmiManager.getBMI(height: heightTextField.text!, weight: weightTextField.text!)
        }
        
        heightTextField.text = ""
        weightTextField.text = ""
        
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두 개의 텍스트 필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
            // 두 번째 텍스트 필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        
        return false
    }
}
