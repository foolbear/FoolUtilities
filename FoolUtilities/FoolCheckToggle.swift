//
//  FoolCheckToggle.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/3/2.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolCheckToggle<Label> : View where Label : View {
    @Binding var isOn: Bool
    let label: Label
    
    public init(isOn: Binding<Bool>, @ViewBuilder label: () -> Label) {
        self._isOn = isOn
        self.label = label()
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            label
        }.toggleStyle(FoolCheckToggleStyle())
    }
}

@available(iOS 13.0, *)
struct FoolCheckToggleStyle: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            if configuration.isOn {
                Image(systemName: "checkmark.circle.fill").onTapGesture(perform: { configuration.isOn.toggle() } )
            } else {
                Image(systemName: "circle").onTapGesture(perform: { configuration.isOn.toggle() } )
            }
            configuration.label
        }
    }
}

@available(iOS 13.0, *)
struct TestFoolCheckToggleView: View {
    @State private var isOn = false
    var body: some View {
        FoolCheckToggle(isOn: $isOn) {
            HStack {
                Text(isOn ? "ON" : "OFF")
                Spacer()
            }
        }
    }
}

@available(iOS 13.0, *)
struct FoolCheckToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        TestFoolCheckToggleView()
    }
}
