//
//  ToastManager.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/01.
//

import SwiftUI

class ToastManager {
    @Binding var messages: [NotificationMessage]
    @Binding var shownMessages: [NotificationMessage]

    init(
        messages: Binding<[NotificationMessage]>,
        shownMessages: Binding<[NotificationMessage]>
    ) {
        self._messages = messages
        self._shownMessages = shownMessages
    }

    func showToast() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }

        // 새로운 메시지만 그리기 위해 filter
        let newMessages = messages.filter { !shownMessages.contains($0) }

        for (index, message) in newMessages.reversed().enumerated() {
            // 초기 높이 값 지정
            let initialYPosition = rootViewController.view.frame.size.height - 100 + CGFloat(index * 50)
            // 최종 높이 값 지정
            let finalYPosition = rootViewController.view.frame.size.height - 100 - CGFloat((messages.count - 1 - index) * 50)

            // Toast UI
            let toastLabel = UILabel(
                frame: CGRect(
                    x: rootViewController.view.frame.size.width / 2 - 75,
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
            toastLabel.isUserInteractionEnabled = true

            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(ToastManager.handleTap(_:))
            )

            toastLabel.addGestureRecognizer(tapGesture)

            rootViewController.view.addSubview(toastLabel)

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

    @objc private static func handleTap(_ sender: UITapGestureRecognizer) {
        if let toastLabel = sender.view as? UILabel {
            UIView.animate(withDuration: 1.0, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }
}
