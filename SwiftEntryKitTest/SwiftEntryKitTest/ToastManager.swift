//
//  ToastManager.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/01.
//

import Combine
import SwiftUI

class ToastManager {

    static let shared = ToastManager()
    private var cancellabels: Set<AnyCancellable> = []

    @Published var messages: [NotificationMessage]
    @Published var shownMessages: [NotificationMessage]

    init(
        messages: [NotificationMessage] = [],
        shownMessages: [NotificationMessage] = []
    ) {
        self.messages = messages
        self.shownMessages = shownMessages

        binding()
    }

    private func binding() {
        $messages.receive(on: DispatchQueue.main)
            .sink { message in
                print(message)
            }
            .store(in: &cancellabels)
    }

    func showToast() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        window.addGestureRecognizer(tapGesture)
        window.isUserInteractionEnabled = true
        

        // 새로운 메시지만 그리기 위해 filter
        let newMessages = messages.filter { !shownMessages.contains($0) }

        for (index, message) in newMessages.reversed().enumerated() {
            // 초기 높이 값 지정
            let initialYPosition = window.frame.size.height - 100 + CGFloat(index * 50)
            // 최종 높이 값 지정
            let finalYPosition = window.frame.size.height - 100 - CGFloat((messages.count - 1 - index) * 50)

            // Toast UI
            let toastLabel = UILabel(
                frame: CGRect(
                    x: window.frame.size.width / 2 - 75,
                    y: initialYPosition,
                    width: 150,
                    height: 35
                )
            )
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center
            toastLabel.text = message.uuid
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true

            let tapGesture = CustomNotificationGestureRecognizer(
                target: self,
                action: #selector(handleTap)
            )
            tapGesture.tapAction = {
                self.messages = self.messages.filter{
                    $0.uuid != message.uuid
                }
                self.shownMessages = self.shownMessages.filter{
                    $0.uuid != message.uuid
                }
            }
            toastLabel.addGestureRecognizer(tapGesture)
            toastLabel.isUserInteractionEnabled = true

            window.addSubview(toastLabel)

            // 아래에서 위로 올라오는 애니메이션
            UIView.animate(
                withDuration: 1.0, delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    toastLabel.frame.origin.y = finalYPosition
                },
                completion: { _ in }
            )

            self.shownMessages.append(message)
        }
    }

    @objc private func handleTap(_ sender: CustomNotificationGestureRecognizer) {
        if let toastLabel = sender.view as? UILabel {
            UIView.animate(withDuration: 1.0, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
            sender.tapAction?()
        }
    }
}

class CustomNotificationGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .recognized
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }

    var tapAction: (() -> Void)?
}
