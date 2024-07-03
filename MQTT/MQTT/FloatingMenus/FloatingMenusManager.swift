//
//  FloatingMenusManager.swift
//  MQTT
//
//  Created by Jeongwan Kim on 2024/07/03.
//

import UIKit
import SwiftUI

struct FloatingMenu {
    let title: String
    let action: () -> Void
}

class FloatingMenusManager {
    static let shared = FloatingMenusManager()
    
    // 화면에 표시할 좌표 값
    var positionX: CGFloat?
    var positionY: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
    var floatingMenus: [FloatingMenu]?

    private var floatingMenusUIView: UIView?

    init() {
        print("FloatingMenusManager init")
    }

    deinit {
        print("FloatingMenusManager Deinit")
        cleanup()
    }

    func showFloatingMenus(
        positionX: CGFloat,
        positionY: CGFloat,
        width: CGFloat,
        height: CGFloat,
        floatingMenus: [FloatingMenu]
    ) {
        // 화면의 최상단 윈도우를 찾기
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        // 윈도우에 탭 제스처 인식기 추가
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(windowTapped))
        tapGestureRecognizer.cancelsTouchesInView = false
        window.addGestureRecognizer(tapGestureRecognizer)
        window.isUserInteractionEnabled = true

        let sampleMenus: [FloatingMenu] = [
            FloatingMenu(
                title: "1",
                action: {
                    print("1")
                }
            ),
            FloatingMenu(
                title: "2",
                action: {
                    print("2")
                }
            ),
            FloatingMenu(
                title: "3",
                action: {
                    print("3")
                }
            )
        ]

        // FloatingMenusView 설정
        let floatingMenusView = FloatingMenusView(
            width: width,
            height: height,
            floatingMenus: sampleMenus
        )

        // UIHostingController를 사용하여 SwiftUI 뷰를 추가
        let floatingMenusVC = UIHostingController(rootView:floatingMenusView)
        floatingMenusVC.view.frame = CGRect(x: positionX, y: positionY, width: width, height: height)

        if floatingMenusUIView == nil {
            window.addSubview(floatingMenusVC.view)
            // // 나중에 제거할 수 있도록 floatingMenusView 저장
            self.floatingMenusUIView = floatingMenusVC.view
        }
    }

    @objc private func windowTapped(_ sender: UIGestureRecognizer) {
        guard let floatingMenusUIView else { return }
        let location = sender.location(in: floatingMenusUIView.superview)
        if !floatingMenusUIView.frame.contains(location) {
            cleanup()
        }
    }

    private func cleanup() {
        floatingMenusUIView?.removeFromSuperview()
        floatingMenusUIView = nil
    }
}
