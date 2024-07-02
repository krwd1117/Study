//
//  ToastManager.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/01.
//

import Combine
import SwiftUI

class NotificationToastManager {
    static let shared = NotificationToastManager()
    private var cancellabels: Set<AnyCancellable> = []

    @Published var messages: [NotificationMessage]
    @Published var shownMessages: [NotificationMessage]

    var maxCount: Int

    init(
        messages: [NotificationMessage] = [],
        shownMessages: [NotificationMessage] = [],
        maxCount: Int = 5
    ) {
        self.messages = messages
        self.shownMessages = shownMessages
        self.maxCount = maxCount
        
        binding()
    }

    private func binding() {
        $messages.receive(on: DispatchQueue.main)
            .sink { message in
                self.showToast()
            }
            .store(in: &cancellabels)
    }

    func insertMessage(message: NotificationMessage) {
        if messages.count < maxCount {
            messages.append(message)
        }
    }

    func deleteMessage(message: NotificationMessage) {
        self.messages = self.messages.filter{
            $0.uuid != message.uuid
        }
        self.shownMessages = self.shownMessages.filter{
            $0.uuid != message.uuid
        }
        reRendering()
    }

    func showToast() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        // 새로운 메시지만 그리기 위해 filter
        let newMessages = messages.filter { !shownMessages.contains($0) }

        for (index, message) in newMessages.reversed().enumerated() {
            // 초기 높이 값 지정
            let initialYPosition = window.frame.size.height - 100 + CGFloat(index * 50)
            // 최종 높이 값 지정
            let finalYPosition = window.frame.size.height - 100 - CGFloat((messages.count - 1 - index) * 50)

            let toastView = NotificationToastUIView(
                frame: CGRect(
                    x: window.frame.size.width / 2 - 75,
                    y: initialYPosition,
                    width: 150,
                    height: 35
                ),
                message: message,
                tapAction: { [weak self] in
                    self?.deleteMessage(message: message)
                }
            )

            window.addSubview(toastView)

            // 아래에서 위로 올라오는 애니메이션
            UIView.animate(
                withDuration: 1.0, delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    toastView.frame.origin.y = finalYPosition
                },
                completion: { _ in }
            )

            self.shownMessages.append(message)
        }
    }

    /// 중간에 있는 메시지를 터치하여 목록에서 지울 때, 상단의 메시지가 그 위치에 그대로 보여지는 것 대신 밑으로 이동시키기 위해 새롭게 화면을 그림
    private func reRendering() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        for (index, message) in shownMessages.enumerated() {
            let finalYPosition = window.frame.size.height - 100 - CGFloat(index * 50)

            if let toastView = window.subviews.first(where: { ($0 as? NotificationToastUIView)?.message.uuid == message.uuid }) {
                UIView.animate(
                    withDuration: 0.5,
                    animations: {
                        toastView.frame.origin.y = finalYPosition
                    }
                )
            }
        }
    }
}
