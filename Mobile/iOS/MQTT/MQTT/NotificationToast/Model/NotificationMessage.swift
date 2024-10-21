//
//  NotificationMessage.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/07/02.
//

import Foundation

struct NotificationMessage: Equatable {
    let uuid: String
    var message: String?

    init(
        uuid: String = UUID().uuidString,
        message: String? = "unKnwon Message"
    ) {
        self.uuid = uuid
        self.message = message
    }
}

extension NotificationMessage {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
