//
//  FoolProgressBar.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/14.
//  Copyright © 2019 Foolbear Co.,Ltd. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, *)
public struct FoolProgressBar: View {
    var progress: Double
    var size: CGSize
    var foregroundColor: Color = .blue
    var backgroundColor: Color = .secondary
    var axes: Axis.Set = .horizontal
    var alignment: Alignment = .leading
    var cornerRadius: CGFloat = 8
    var animation: Animation? = .linear(duration: 0.5)
    var barWidth: CGFloat {
        if axes == .horizontal {
            return self.isShowing ? size.width * CGFloat(progress) / 100.0 : 0.0
        } else {
            return size.width
        }
    }
    var barHeight: CGFloat {
        if axes == .horizontal {
            return size.height
        } else {
            return self.isShowing ? size.height * CGFloat(progress) / 100.0 : 0.0
        }
    }
    @State private var isShowing = false
    
    public init(progress: Double, size: CGSize, cornerRadius: CGFloat, axes: Axis.Set = .horizontal, alignment: Alignment = .leading, foregroundColor: Color = .blue, backgroundColor: Color = .secondary, animation: Animation? = .linear(duration: 0.5)) {
        self.progress = progress
        self.size = size
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.axes = axes
        self.alignment = alignment
        self.cornerRadius = cornerRadius
        self.animation = animation
    }
    
    public init(progress: Double, size: CGSize, axes: Axis.Set = .horizontal, alignment: Alignment = .leading, foregroundColor: Color = .blue, backgroundColor: Color = .secondary, animation: Animation? = .linear(duration: 0.5)) {
        self.progress = progress
        self.size = size
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.axes = axes
        self.alignment = alignment
        self.cornerRadius = axes == .horizontal ? size.height / 2.0 : size.width / 2.0
        self.animation = animation
    }
    
    public var body: some View {
        ZStack(alignment: alignment) {
            Rectangle()
                .foregroundColor(backgroundColor)
                .opacity(0.3)
                .frame(width: size.width, height: size.height)
            Rectangle()
                .foregroundColor(foregroundColor)
                .frame(width: barWidth, height: barHeight)
                .animation(animation)
        }
        .onAppear {
            self.isShowing = true
        }
        .cornerRadius(cornerRadius)
    }
}

@available(iOS 13.0, OSX 10.15, *)
struct FoolProgressBarTestView: View {
    @State private var progress: Double = 34
    var body: some View {
        FoolProgressBar(progress: progress, size: CGSize(width: 150, height: 320), cornerRadius: 10, axes: .vertical, alignment: .bottom)
            .onTapGesture {
                self.progress += 10
                if self.progress > 100 {
                    self.progress = 0
                }
        }
    }
}

@available(iOS 13.0, OSX 10.15, *)
struct FoolProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FoolProgressBar(progress: 40, size: CGSize(width: 320, height: 20), alignment: .leading)
            FoolProgressBar(progress: 25, size: CGSize(width: 320, height: 20), alignment: .trailing)
            FoolProgressBar(progress: 25, size: CGSize(width: 320, height: 20), cornerRadius: 10)
            FoolProgressBar(progress: 25, size: CGSize(width: 150, height: 320), cornerRadius: 10, axes: .vertical, alignment: .top)
            FoolProgressBarTestView()
        }
    }
}
