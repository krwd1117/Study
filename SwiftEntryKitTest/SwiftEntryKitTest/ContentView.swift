//
//  ContentView.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/06/28.
//

import SwiftUI
import SwiftEntryKit

struct NotificationMessage: Equatable {
    let uuid: String = UUID().uuidString
}

extension NotificationMessage {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

class ContentViewModel: ObservableObject {
    @Published var isAlertShow: Bool
    @Published var messages: [NotificationMessage]
    @Published var shownMessages: [NotificationMessage]

    init(
        isAlertShow: Bool = false,
        messages: [NotificationMessage] = [],
        shownMessages: [NotificationMessage] = []
    ) {
        self.isAlertShow = isAlertShow
        self.messages = messages
        self.shownMessages = shownMessages

        binding()
    }

    func insertMessage(message: String) {
        self.messages.append(NotificationMessage())
    }

    private func binding() {}
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Button(action: {
                viewModel.insertMessage(message: UUID().uuidString)

                let toastManager = ToastManager(
                    messages: $viewModel.messages,
                    shownMessages: $viewModel.shownMessages
                )
                toastManager.showToast()

            }) {
                Text("Show Toast Messages")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
class Utils {
    static func getRootViewController() -> UIViewController? {
        return UIApplication.shared.windows.first?.rootViewController
    }
}

#Preview {
    ContentView()
}
