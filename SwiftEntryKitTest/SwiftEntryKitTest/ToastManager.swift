//
//  ToastManager.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/01.
//

import SwiftUI

class ToastManager {
    @Published var messages: [NotificationMessage] = []
    @Published var shownMessages: [NotificationMessage] = []

    static let shared = ToastManager()

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
                    width: 200,
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

            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(handleTap)
            )
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

    @objc private func handleTap(_ sender: UIGestureRecognizer) {
        if let toastLabel = sender.view as? UILabel {
            UIView.animate(withDuration: 1.0, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }
}
