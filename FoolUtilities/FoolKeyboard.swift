//
//  FoolKeyboard.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/3.
//

import SwiftUI

@available(iOS 13.0, *)
public class FoolKeyboard: ObservableObject {
    private var center: NotificationCenter
    @Published var height: CGFloat = 0

    init(center: NotificationCenter = .default) {
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
