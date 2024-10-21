//
//  CustomNotificationGestureRecognizer.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/02.
//

import UIKit

class CustomNotificationGestureRecognizer: UIGestureRecognizer {
    var tapAction: (() -> Void)?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .recognized
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}
