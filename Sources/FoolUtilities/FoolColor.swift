//
//  FoolColor.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/20.
//

#if !os(macOS)

import Foundation
import SwiftUI

public extension UIColor {
    
    convenience init(rgbHex: UInt) {
        self.init(
            red: CGFloat((rgbHex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbHex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbHex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(rgbaHex: UInt) {
        self.init(
            red: CGFloat((rgbaHex & 0xFF000000) >> 24) / 255.0,
            green: CGFloat((rgbaHex & 0x00FF0000) >> 16) / 255.0,
            blue: CGFloat((rgbaHex & 0x0000FF00) >> 8) / 255.0,
            alpha: CGFloat(rgbaHex & 0x000000FF) / 255.0
        )
    }
    
}

@available(iOS 13.0, *)
public extension Color {
    
    init(rgbHex: UInt) {
        self.init(UIColor(rgbHex: rgbHex))
    }
    
    init(rgbaHex: UInt) {
        self.init(UIColor(rgbaHex: rgbaHex))
    }
    
}

#endif
