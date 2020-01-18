//
//  FoolProgressRing.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/13.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolProgressRing: View {
    var progress: Double
    var foregroundColor: Color = .blue
    var backgroundColor: Color = .secondary
    var lineWidth: CGFloat = 4
    var animation: Animation? = .linear(duration: 0.5)
    @State private var isShowing = false
    
    public init(progress: Double, foregroundColor: Color = .blue, backgroundColor: Color = .secondary, lineWidth: CGFloat = 4, animation: Animation? = .linear(duration: 0.5)) {
        self.progress = progress
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.lineWidth = lineWidth
        self.animation = animation
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)
                .opacity(0.3)
            Circle()
                .trim(from: 0, to: isShowing ? CGFloat(progress) / 100.0 : 0)
                .stroke(foregroundColor, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
                .animation(animation)
        }
        .onAppear {
            self.isShowing = true
        }
    }
}

@available(iOS 13.0, *)
struct FoolProgressRingTestView: View {
    @State private var progress: Double = 34
    var body: some View {
        FoolProgressRing(progress: progress)
            .onTapGesture {
                self.progress += 10
                if self.progress > 100 {
                    self.progress = 0
                }
        }
        .frame(height: 300)
    }
}

@available(iOS 13.0.0, *)
struct FoolProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FoolProgressRing(progress: 40).frame(height: 200)
            FoolProgressRingTestView()
        }
    }
}
