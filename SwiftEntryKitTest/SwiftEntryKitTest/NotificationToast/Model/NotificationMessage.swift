//
//  NotificationMessage.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/02.
//

import Foundation

struct NotificationMessage: Equatable {
    let uuid: String = UUID().uuidString
}

extension NotificationMessage {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
