//
//  FoolHeaderView.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/1.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolHeaderView<Leading, Title, Trailing>: View where Leading: View, Title: View, Trailing: View {
    var leading: Leading
    var title: Title
    var trailing: Trailing
    
    public init(leading: Leading, title: Title, trailing: Trailing) {
        self.leading = leading
        self.title = title
        self.trailing = trailing
    }
    
    public var body: some View {
        VStack() {
            Spacer()
                .frame(height: 8)
            ZStack {
                HStack {
                    Spacer()
                    title
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        leading.padding()
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        trailing.padding()
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
        FoolHeaderView(leading: EmptyView(), title: Text("Title"), trailing:
            Button(action: {}) {
                Text("Done")
        })
    }
}
