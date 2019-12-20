//
//  FoolColor.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/20.
//

import Foundation
import UIKit

public extension UIColor {
    
    convenience init(rgbHex: UInt) {
        self.init(
            red: CGFloat((rgbHex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbHex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbHex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
