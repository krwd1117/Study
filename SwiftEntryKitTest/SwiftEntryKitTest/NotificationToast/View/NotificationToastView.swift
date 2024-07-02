//
//  NotificationToastView.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/02.
//

import SwiftUI

struct NotificationToastView: UIViewRepresentable {
    var message: NotificationMessage

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true

        let label = UILabel()
        label.text = message.uuid
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            view.heightAnchor.constraint(equalToConstant: 35),
            view.widthAnchor.constraint(equalToConstant: 150)
        ])

        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(context.coordinator.handleTap)
        )
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true

        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension NotificationToastView {
    class Coordinator: NSObject {
        var parent: NotificationToastView

        init(parent: NotificationToastView) {
            self.parent = parent
        }

        @objc func handleTap() {
            NotificationToastManager.shared.deleteMessage(message: parent.message)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}
