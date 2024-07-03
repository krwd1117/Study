//
//  FloatingMenusView.swift
//  MQTT
//
//  Created by Jeongwan Kim on 2024/07/03.
//

import SwiftUI

struct FloatingMenusView: View {
    let width: CGFloat
    let height: CGFloat
    let floatingMenus: [FloatingMenu]

    init(
        width: CGFloat,
        height: CGFloat,
        floatingMenus: [FloatingMenu]
    ) {
        self.width = width
        self.height = height
        self.floatingMenus = floatingMenus
    }

    var body: some View {
        VStack {
            ForEach(floatingMenus, id: \.title) { menu in
                Button(action: {
                    menu.action()
                }, label: {
                    Text(menu.title)
                        .background(Color.yellow)
                })
            }
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
}
