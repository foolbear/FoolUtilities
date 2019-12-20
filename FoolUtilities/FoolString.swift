//
//  FoolString.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/20.
//

import Foundation

public extension String {
    
    func subString(start: Int, length: Int = -1) -> String {
        let count = self.count
        var len = length
        if len == -1 {
            len = self.count - start
        }
        if start + len > count {
            len = count - start
        }
        let s = self.index(self.startIndex, offsetBy: start)
        let e = self.index(s, offsetBy: len)
        return String(self[s ..< e])
    }
    
}
