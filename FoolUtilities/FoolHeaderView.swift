//
//  FoolHeaderView.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/1.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolHeaderView: View {
    var leadingButton: AnyView?
    var title: AnyView?
    var trailingButton: AnyView?
    
    public var body: some View {
        VStack() {
            Spacer()
                .frame(height: 20)
            ZStack {
                HStack {
                    Spacer()
                    title
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        leadingButton.padding()
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        trailingButton.padding()
                    }
                }
            }
            Divider()
        }
    }
}
