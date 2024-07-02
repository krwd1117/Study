//
//  MQTTManager.swift
//  MQTT
//
//  Created by Jeongwan Kim on 6/24/24.
//

import Foundation
import CocoaMQTT

class MQTTManager {
    private var mqtt: CocoaMQTT? = nil
    private var notificationToastManager: NotificationToastManager? = nil

    static let shared = MQTTManager()
    
    init(mqtt: CocoaMQTT? = nil) {


        self.notificationToastManager = NotificationToastManager(maxCount: 5)

        let clientID = "Test"
        let host = "broker.hivemq.com"
        let port: UInt16 = 1883
//        let userName = "test1234"
//        let password = "Test1234"
        
        self.mqtt = CocoaMQTT(clientID: clientID, host: host, port: port)
//        self.mqtt?.username = userName
//        self.mqtt?.password = password
        self.mqtt?.keepAlive = 60
        self.mqtt?.autoReconnect = true // 네트워크 끊겨도 다시 연결 시고
        self.mqtt?.delegate = self
        
        _ = self.mqtt?.connect()
    }
}

// MARK: - CocoaMQTTDelegate
extension MQTTManager: CocoaMQTTDelegate {
    
    /// MQTT가 연결이 된 후 ack가 접속 허용(.accept)되었을 때 Topic을 구독
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print(":::: didConnectAck ::::")
        mqtt.subscribe("test1234", qos: .qos0)
    }
    
    ///클라이언트가 브로커에 메시지를 보낼 때 ID를 생성(양방향일때 사용)
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print(":::: didPublishMessage ::::")
        print(":::: message : \(message.string ?? "nil msg") , id: \(id)")
    }
    
    /// 클라이언트가 브로커에 메시지를 보낼 때(양방향일때 사용)
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print(":::: didPublishAck ::::")
        print(":::: id: \(id)")
    }
    
    /// MQTT 메시지를 받아와서 처리하는 부분.
    /// 브로커가 클라이언트에 메시지를 보낼 때 ID를 생성
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print(":::: 📥didReceiveMessage ::::")
        print(":::: 📥message : \(message.string ?? "nil msg") , id: \(id)")

        let message = NotificationMessage(message: message.string)
        notificationToastManager?.insertMessage(message: message)
    }
    
    /// Topic 구독 성공 여부
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print(":::: didSubscribeTopics ::::")
        print(":::: success: \(success)")
        print(":::: failed: \(failed)")
    }
    
    /// Topic 구독 해제
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print(":::: didUnsubscribeTopics ::::")
        print(":::: topics: \(topics)")
    }
    
    /// 연결이 되어 있다면 일정 시간 마다 1분마다 mqttDidPing 호출
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print(":::: mqttDidPing ::::")
        print(":::: mqtt 연결상태 : \(mqtt.connState.description)\n")
    }
    
    /// 연결이 되어 있다면 일정 시간 마다 1분마다 mqttDidReceivePong 호출 - mqttDidPing이 호출된다음(핑퐁)
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print(":::: mqttDidReceivePong ::::")
        print(":::: mqtt 연결상태 : \(mqtt.connState.description)\n")
    }
    
    ///     MQTT connect시 실패 + disconnect
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print(":::: mqttDidReceivePong ::::")
        print(":::: err : \(err?.localizedDescription ?? "error...")")
    }
    
    /// MQTT 연결진행 중 상태가 변경되었을 경우
//    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
//        <#code#>
//    }
    
    /// SSL/TLS 서버 인증서를 수동으로 검증
    /// 이 메서드는 `allowUntrustCACertificate`를 활성화하면 호출 됨
//    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
//        <#code#>
//    }
}
