import UIKit

// 텍스트 필드 프로토콜
protocol RemoteControlDelegate {
    func channelUp()
    func channelDown()
}

// 텍스트 필드의 역할
class RemoteControl {
    
    var delegate: RemoteControlDelegate?
    
    func doSomething() {
     print("리모콘 조작이 일어나고 있음")
    }
    
    func channelUp() {
        /// 대리자의 channelUp()을 호출
        /// 대리자를 채택한 녀석에게 일을 시킴
        delegate?.channelUp()
    }

    func channelDown() {
        delegate?.channelDown()
    }
    
}

// ViewController의 역할
class TV: RemoteControlDelegate {
    
    func channelUp() {
        print("TV의 채널이 올라감")
    }
    
    func channelDown() {
        print("TV의 채널이 내려감")
    }
}


let remote = RemoteControl()
let samsungTV = TV()

/// ex) textField.delegate = self
/// 리모트의 대리자를 삼성TV로 설정
remote.delegate = samsungTV
remote.channelUp()
remote.channelDown()


class SmartPhone: RemoteControlDelegate {
    
    init(remote: RemoteControl) {
        remote.delegate = self
    }
    
    func channelUp() {
        print("스마트폰의 채널이 올라간다.")
    }
    
    func channelDown() {
        print("스마트폰의 채널이 내려간다.")
    }
}

let smartPhone = SmartPhone(remote: remote)
remote.channelUp()
remote.channelDown()
