//
//  NotificationToastUIView.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/02.
//

import UIKit

class NotificationToastUIView: UIView {

    var message: NotificationMessage
    var tapAction: (() -> Void)?

    init(
        frame: CGRect,
        message: NotificationMessage,
        tapAction: @escaping () -> Void
    ) {
        self.message = message
        self.tapAction = tapAction
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let label = UILabel()
        label.text = message.message
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true

        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 10
            ),
            label.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -10
            ),
        ])

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }

    @objc private func handleTap(_ sender: CustomNotificationGestureRecognizer) {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
        tapAction?()
    }
}
