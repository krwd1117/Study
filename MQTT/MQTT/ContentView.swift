//
//  ContentView.swift
//  MQTT
//
//  Created by Jeongwan Kim on 6/24/24.
//

import SwiftUI

struct ContentView: View {

    let mqtt: MQTTManager?

    init() {
        mqtt = MQTTManager.shared
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
