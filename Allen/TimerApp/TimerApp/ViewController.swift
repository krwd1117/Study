//
//  ViewController.swift
//  TimerApp
//
//  Created by Jeongwan Kim on 2023/09/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
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
        let seconds = Int(sender.value * 60)
        mainLabel.text = "\(seconds) 초"
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 셋팅
        mainLabel.text = "초를 선택하세요."
        timeSlider.setValue(0.5, animated: true)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 메인 라벨의 값이 1씩 감소
    }
}

