//
//  FoolTextField.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/9.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolTextField: UIViewRepresentable {
    public typealias OnBeginEditing = () -> Void
    @Binding var text: String
    private let textField = UITextField(frame: .zero)
    private let onBeginEditing: OnBeginEditing?
    
    public init(_ placeholder: String, text: Binding<String>, onBeginEditing: OnBeginEditing? = nil) {
        _text = text
        textField.text = text.wrappedValue
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        self.onBeginEditing = onBeginEditing
    }
    
    public func makeUIView(context: UIViewRepresentableContext<FoolTextField>) -> UITextField {
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.delegate = context.coordinator
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<FoolTextField>) { uiView.text = text }
    
    public func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        var foolTextField: FoolTextField
        
        init(_ foolTextField: FoolTextField) {
            self.foolTextField = foolTextField
            super.init()
            NotificationCenter.default.addObserver(self, selector: #selector(Self.textDidChanged(_:)), name: UITextField.textDidChangeNotification, object: foolTextField.textField)
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            foolTextField.onBeginEditing?()
        }
        
        @objc private func textDidChanged(_ notification: Notification) {
            let textField = foolTextField.textField
            if textField.markedTextRange == nil {
                foolTextField.text = textField.text ?? String()
            }
        }
    }
}
