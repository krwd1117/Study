import UIKit
import Combine

enum MyError: Error {
    case subscriberError
}

/*
// 서브스크라이버 생성하는 방법
class StringSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = MyError
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completion")
    }
}

/// 서브스크라이버 인스턴스 생성
/// ex) 유튜버 생성
let subscriber = StringSubscriber()

let subject = PassthroughSubject<String, MyError>()

/// 구독(서브스크라이버)
/// ex) 구독 버튼을 누름
subject.subscribe(subscriber)

/// 유튜브에 영상 올리기
subject.send("A")
subject.send("B")

// receive(subscription: Subscription)에서 .request의 최대 값을 2로 설정해서 C는 출력되지 않음
// receive(_ input: String) 에서 return 값을 .max(1)로 수정하면 출력 가능
subject.send("C")
*/

// ---- 위에서 만든 서브스크라이버 만드는 로직을 한 번에 쉽게 처리해주는 .sink ----

let subject = PassthroughSubject<String, MyError>()

var subscription = subject.sink { completion in
    // receive(completion: Subscribers.Completion<MyError>)
    print(completion)
} receiveValue: { value in
    // receive(_ input: String) -> Subscribers.Demand
    print(value)
}

subject.send("A")
subject.send("B")

// 구독 취소
subscription.cancel()

subject.send("C")
subject.send("D")
