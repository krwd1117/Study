//
//  NotificationCenterView.swift
//  CombineStudy
//
//  Created by Jeongwan Kim on 2023/01/06.
//

import SwiftUI

struct NotificationCenterView: View {
    var body: some View {
        Text("")
            .onAppear {
                let notificationName = Notification.Name("MyNotification")
                
                /// 퍼블리셔
                let publisher = NotificationCenter.default.publisher(for: notificationName, object: nil)
                
                /// 아직 publisher의 구독자가 없으므로 아무것도 하지 않음
                NotificationCenter.default.post(name: notificationName, object: nil)
                
                /// sink는 구독의 대표적인 함수
                let subScription = publisher.sink { noticiation in
                    print("Notification Received!")
                }
                
                /// publisher를 구독(sink) 하고 있으므로, 로그를 출력함
                NotificationCenter.default.post(name: notificationName, object: nil)
                
                /// subScription을 cancel하지 않으면 메모리 누수가 발생할 수 있음 (store에 담거나, 직접 해제 )
                subScription.cancel()
                
                /// cancel로 구독을 해제 했으므로 더 이상 post를 보내도 로그 찍히지 않음
                NotificationCenter.default.post(name: notificationName, object: nil)
            }
    }
    
}
