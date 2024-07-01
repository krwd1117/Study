//
//  ContentView.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/06/28.
//

import SwiftUI
import Combine

struct NotificationMessage: Equatable {
    let uuid: String = UUID().uuidString
}

extension NotificationMessage {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

class ContentViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Published var toastManager: ToastManager

    init(toastManager: ToastManager = ToastManager()) {
        self.toastManager = toastManager

        binding()
    }

    private func binding() {
        toastManager.$messages.receive(on: DispatchQueue.main)
            .sink { _ in
                self.toastManager.showToast()
            }
            .store(in: &cancellables)
    }

    func insertMessage(message: NotificationMessage = NotificationMessage()) {
        toastManager.insertMessage(message: message)
    }
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Button(action: {
                viewModel.insertMessage()
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
