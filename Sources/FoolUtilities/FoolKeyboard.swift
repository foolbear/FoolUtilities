//
//  FoolKeyboard.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/3.
//

#if !os(macOS)

import SwiftUI

@available(iOS 13.0, *)
public class FoolKeyboard: ObservableObject {
    public static let shared = FoolKeyboard()
    @Published public var height: CGFloat = 0
    private var center: NotificationCenter

    private init(center: NotificationCenter = .default) {
        self.center = center
        self.center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        self.center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        self.center.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            height = keyboardSize.height
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        height = 0
    }
}

#endif
