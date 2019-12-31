//
//  FoolView.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/31.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
