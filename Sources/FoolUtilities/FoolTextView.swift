//
//  FoolTextView.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/4/2.
//

#if !os(macOS)

import SwiftUI

@available(iOS 13.0, *)
public struct FoolTextView<Placeholder>: View where Placeholder: View {
    public struct TextView: UIViewRepresentable {
        @Binding private var text: String
        @Binding private var textChangedOutside: Bool
        private let textAlignment: TextAlignment
        private let font: UIFont
        private let textColor: UIColor
        private let backgroundColor: UIColor
        private let autocorrection: Autocorrection
        private let autocapitalization: Autocapitalization
        private let isSecure: Bool
        private let isEditable: Bool
        private let isSelectable: Bool
        private let isScrollingEnabled: Bool
        private let isUserInteractionEnabled: Bool
        
        public init(
            text: Binding<String>,
            textChangedOutside: Binding<Bool>,
            textAlignment: TextAlignment,
            font: UIFont,
            textColor: UIColor,
            backgroundColor: UIColor,
            autocorrection: Autocorrection,
            autocapitalization: Autocapitalization,
            isSecure: Bool,
            isEditable: Bool,
            isSelectable: Bool,
            isScrollingEnabled: Bool,
            isUserInteractionEnabled: Bool
        ) {
            self._text = text
            self._textChangedOutside = textChangedOutside
            self.textAlignment = textAlignment
            self.font = font
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.autocorrection = autocorrection
            self.autocapitalization = autocapitalization
            self.isSecure = isSecure
            self.isEditable = isEditable
            self.isSelectable = isSelectable
            self.isScrollingEnabled = isScrollingEnabled
            self.isUserInteractionEnabled = isUserInteractionEnabled
        }
        
        public func makeUIView(context: Context) -> UITextView {
            let uiTextView = UITextView()
            uiTextView.textAlignment = textAlignment
            uiTextView.font = font
            uiTextView.textColor = textColor
            uiTextView.backgroundColor = backgroundColor
            uiTextView.autocorrectionType = autocorrection
            uiTextView.autocapitalizationType = autocapitalization
            uiTextView.isSecureTextEntry = isSecure
            uiTextView.isEditable = isEditable
            uiTextView.isSelectable = isSelectable
            uiTextView.isScrollEnabled = isScrollingEnabled
            uiTextView.isUserInteractionEnabled = isUserInteractionEnabled
            uiTextView.delegate = context.coordinator
            return uiTextView
        }
        
        public func updateUIView(_ uiView: UITextView, context : UIViewRepresentableContext<TextView>) {
            guard textChangedOutside == true else { return }
            uiView.text = text
        }
        
        public func makeCoordinator() -> Coordinator { Coordinator(self) }
        
        public class Coordinator: NSObject, UITextViewDelegate {
            private let textView: TextView
            
            public init(_ textView: TextView) {
                self.textView = textView
                super.init()
            }
            
            public func textViewDidChange(_ uiTextView: UITextView) {
                textView.textChangedOutside = false
                textView.text = uiTextView.text
            }
        }
    }
    
    public typealias TextAlignment = NSTextAlignment
    public typealias Autocorrection = UITextAutocorrectionType
    public typealias Autocapitalization = UITextAutocapitalizationType
    
    @Binding private var text: String
    @Binding private var textChangedOutside: Bool
    @State private var isEditing: Bool = false
    private let textAlignment: TextAlignment
    private let font: UIFont
    private let textColor: UIColor
    private let placeholder: () -> Placeholder
    private let placeholderAlignment: Alignment
    private let backgroundColor: UIColor
    private let autocorrection: Autocorrection
    private let autocapitalization: Autocapitalization
    private let isSecure: Bool
    private let isEditable: Bool
    private let isSelectable: Bool
    private let isScrollingEnabled: Bool
    private let isUserInteractionEnabled: Bool
    
    public init(
        text: Binding<String>,
        textChangedOutside: Binding<Bool>,
        textAlignment: TextAlignment = .left,
        font: UIFont = UIFont.preferredFont(forTextStyle: .body),
        textColor: UIColor = .label,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        placeholderAlignment: Alignment = .topLeading,
        backgroundColor: UIColor = .clear,
        autocorrection: Autocorrection = .default,
        autocapitalization: Autocapitalization = .sentences,
        isSecure: Bool = false,
        isEditable: Bool = true,
        isSelectable: Bool = true,
        isScrollingEnabled: Bool = true,
        isUserInteractionEnabled: Bool = true
    ) {
        self._text = text
        self._textChangedOutside = textChangedOutside
        self.textAlignment = textAlignment
        self.font = font
        self.textColor = textColor
        self.placeholder = placeholder
        self.placeholderAlignment = placeholderAlignment
        self.backgroundColor = backgroundColor
        self.autocorrection = autocorrection
        self.autocapitalization = autocapitalization
        self.isSecure = isSecure
        self.isEditable = isEditable
        self.isSelectable = isSelectable
        self.isScrollingEnabled = isScrollingEnabled
        self.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
    private var textView: TextView {
        TextView(text: $text, textChangedOutside: $textChangedOutside, textAlignment: textAlignment, font: font, textColor: textColor, backgroundColor: backgroundColor, autocorrection: autocorrection, autocapitalization: autocapitalization, isSecure: isSecure, isEditable: isEditable, isSelectable: isSelectable, isScrollingEnabled: isScrollingEnabled, isUserInteractionEnabled: isUserInteractionEnabled)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if self.text.isEmpty == true {
                        self.placeholder().frame(width: geometry.size.width, height: geometry.size.height, alignment: self.placeholderAlignment).allowsHitTesting(false)
                    } else {
                        EmptyView()
                    }
                }
                self.textView
            }
        }
    }
}

#endif
