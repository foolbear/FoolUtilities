//
//  FoolHeaderView.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/1.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolHeaderView<Leading, Title, Trailing>: View where Leading: View, Title: View, Trailing: View {
    let title: Title
    let leading: () -> Leading
    let trailing: () -> Trailing
    
    public init(title: Title, leading: @escaping () -> Leading, trailing: @escaping () -> Trailing) {
        self.leading = leading
        self.title = title
        self.trailing = trailing
    }
    
    public var body: some View {
        VStack() {
            Rectangle()
                .frame(width: 60, height: 6)
                .cornerRadius(3.0)
                .opacity(0.3)
                .padding(.top, 16)
            ZStack {
                HStack {
                    Spacer()
                    title
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        leading().padding(.horizontal)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        trailing().padding(.horizontal)
                    }
                }
            }
            Divider()
        }
    }
}

@available(iOS 13.0, *)
struct FoolHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            FoolHeaderView(title: Text("Title"), leading: { EmptyView() }, trailing: {
                Button(action: {}) { Text("Done") }
            })
            Spacer()
        }
    }
}
