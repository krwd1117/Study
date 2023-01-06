//
//  SubScriber.swift
//  CombineStudy
//
//  Created by Jeongwan Kim on 2023/01/06.
//

import SwiftUI
import Combine

struct SubscriberView: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                
                let publisher = ["A", "B", "C", "D", "E", "F"].publisher
                let subscriber = StringSubscriber()
                
                /// 새롭게 만든 subscriber로 publisher를 subscrib
                publisher
                    .subscribe(subscriber)
                
                
            }
    }
}

class StringSubscriber: Subscriber {
    
    typealias Input = String
    
    /// Never: 절대 실패 안함
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        print("Subscriber가 Publisher에게 구독을 신청하면 출력하는 메시지(Received Subsvription)")
        
        /// subscriber가 몇 개의 값을 받을 것인지 (backpressure)
        subscription.request(.max(3))
    }
    
    /// Subscriber가 Publisher에게 전달 받은 값
    func receive(_ input: String) -> Subscribers.Demand {
        print("전달 받은 값: \(input)")
        
        /// 여기서도 몇 개의 값을 받을 것인지 설정 가능
        return .unlimited
    }
    
    /// Subscriber가 publisher에게 값을 모두 전달 받으면 출력하는 메시지
    func receive(completion: Subscribers.Completion<Never>) {
        print("Publisher에게 값 전달 받기 완료")
    }
    
    
}



struct SubscriberView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberView()
    }
}
