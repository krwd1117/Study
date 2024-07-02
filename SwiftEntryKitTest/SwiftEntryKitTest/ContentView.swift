//
//  ContentView.swift
//  SwiftEntryKitTest
//
//  Created by Jeongwan Kim on 2024/06/28.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var toastManager: NotificationToastManager

    init() {
        self.toastManager = NotificationToastManager(maxCount: 5)
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

#Preview {
    ContentView()
}
