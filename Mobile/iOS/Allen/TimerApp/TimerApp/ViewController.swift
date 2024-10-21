//
//  ViewController.swift
//  TimerApp
//
//  Created by Jeongwan Kim on 2023/09/15.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
    weak var timer: Timer?
    var number: Int = 0
    let systemSoundID: SystemSoundID = 1016
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요."
        
        // 슬라이더의 가운데 설정
        timeSlider.setValue(0.5, animated: true)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        // 슬라이더의 밸류 값으로 메인 라벨의 값을 셋팅
        let number = Int(sender.value * 60)
        mainLabel.text = "\(number) 초"
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 셋팅
        timer?.invalidate()
        mainLabel.text = "초를 선택하세요."
        timeSlider.setValue(0.5, animated: true)
        number = 0
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 메인 라벨의 값이 1씩 감소
        
        // 타이머 비활성화
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomethingAfterSecond), userInfo: nil, repeats: true)
    }
    
    @objc func doSomethingAfterSecond() {
        if number > 0 {
            number -= 1
            timeSlider.setValue(Float(number) / Float(60), animated: true)
            mainLabel.text = "\(number) 초"
        } else {
            number = 0
            mainLabel.text = "초를 선택하세요."
            timer?.invalidate()
            AudioServicesPlayAlertSound(systemSoundID)
        }
    }
}

