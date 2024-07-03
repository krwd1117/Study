//
//  ContentView.swift
//  MQTT
//
//  Created by Jeongwan Kim on 6/24/24.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    private var cancellabels: Set<AnyCancellable> = []

    @Published var buttonTappedPosition: CGPoint = .zero

    let mqtt: MQTTManager?

    init() {
        mqtt = MQTTManager.shared
        binding()
    }

    private func bindingg() {
        $buttonTappedPosition
            .dropFirst()
            .sink { point in
            FloatingMenusManager.shared.showFloatingMenus(
                positionX: point.x,
                positionY: point.y,
                width: 250,
                height: 250,
                floatingMenus: []
            )
        }
        .store(in: &cancellabels)
    }
}

struct ContentView: View {

    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Button(
                action: {

                }, label: {
                VStack {
                    Image(systemName: "globe")
                    Text("Hello, world!")
                }
                .padding()
            })
            .simultaneousGesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged {
                        viewModel.buttonTappedPosition = $0.location
                    }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
    }
}

#Preview {
    ContentView()
}
