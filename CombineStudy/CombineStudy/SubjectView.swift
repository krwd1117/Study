//
//  SubjectView.swift
//  CombineStudy
//
//  Created by Jeongwan Kim on 2023/01/07.
//

import SwiftUI
import Combine

enum MyError: Error {
    case subscriberError
}

class CustomSubscriber: Subscriber {
    
    typealias Input = String
    typealias Failure = MyError
    
    /// publisher를 subscriber하면 실행하는 함수
    func receive(subscription: Subscription) {
        print("publisher를 subscrib 했습니다.")
        
        // 몇 개의 값을 받을 것인지
        subscription.request(.max(2))
    }
    
    /// publisher로부터 값을 받는 함수
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
            
//        return .none
        /// 수요를 1씩 증가시킴
        return .max(1)
    }
    
    /// publisher로부터 일을 끝내고 실행하는 함수
    func receive(completion: Subscribers.Completion<MyError>) {
        print("subscrib을 끝냈습니다.")
    }
    
}

struct SubjectView: View {
    var body: some View {
        Text("Subject")
            .onAppear {
                
                let subscriber = CustomSubscriber()
                
                /// PassthroughSubject는 값을 미리 준비하지 않고도 나중에 값을 입력 받아 처리할 수 있도록 하는 subject(publisher)
                let subject = PassthroughSubject<String, MyError>()
                
                /// 1. subscriber를 생성해 subscribtion을 받는 방법
                subject.subscribe(subscriber)
                
                /// 2. 애플에서 구현해둔 sink를 통해 subscribtion을 받는 방법
                let subscribtion = subject.sink { completion in
                    print("sink")
                } receiveValue: { value in
                    print("sink로 부터 받은 값", value)
                }
                
                /// .max() 값의 개수만큼 receive(_ input: String) 함수를 실행
                subject.send("A")
                subject.send("B")
 
                /// sink 구독 취소
                subscribtion.cancel()
                
                
                subject.send("C")
                subject.send("D")
            }
    }
}
