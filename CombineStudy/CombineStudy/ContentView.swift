//
//  ContentView.swift
//  CombineStudy
//
//  Created by Jeongwan Kim on 2023/01/06.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("메인 화면")
                
                NavigationLink {
                    NotificationCenterView()
                } label: {
                    Text("노티피케이션 센터 뷰")
                }
                NavigationLink {
                    SubscriberView()
                } label: {
                    Text("SubScriber")
                }
                NavigationLink {
                    SubjectView()
                } label: {
                    Text("SubjectView")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
