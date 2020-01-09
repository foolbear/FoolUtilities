//
//  FoolTextField.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/9.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolTextField: UIViewRepresentable {
    @Binding var text: String
    private let textField = UITextField(frame: .zero)
    
    init(_ placeholder: String, text: Binding<String>) {
        _text = text
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
    }
    
    public func makeUIView(context: UIViewRepresentableContext<FoolTextField>) -> UITextField {
        textField.delegate = context.coordinator
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<FoolTextField>) {}
    
    public func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        var textField: FoolTextField
        
        init(_ textField: FoolTextField) {
            self.textField = textField
            super.init()
            NotificationCenter.default.addObserver(self, selector: #selector(Self.textDidchange(_:)), name: UITextField.textDidChangeNotification, object: textField.textField)
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        @objc private func textDidchange(_ notification: Notification) {
            let tf = textField.textField
            if tf.markedTextRange == nil {
                textField.text = tf.text ?? String()
            }
        }
    }
}
