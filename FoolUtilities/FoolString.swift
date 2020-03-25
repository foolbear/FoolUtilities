//
//  FoolString.swift
//  FoolUtilities
//
//  Created by foolbear on 2019/12/20.
//

import Foundation

public extension String {
    enum SizeAvailable { case available, empty, oversize }
    
    var localized: String { return NSLocalizedString(self, comment: self) }
    
    func localizedFormat(arguments: CVarArg...) -> String {
        return String.localizedStringWithFormat(self.localized, arguments)
    }
    
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
    
    func isSizeAvailable(_ maxSize: Int = 0) -> SizeAvailable {
        if maxSize != 0 && self.count > maxSize {
            return .oversize
        }
        return self.isEmpty ? .empty : .available
    }
    
    func truncated(_ maxSize: Int) -> String {
        if self.count > maxSize {
            return self.subString(start: 0, length: maxSize)
        }
        return self
    }
    
    mutating func truncate(_ maxSize: Int) {
        if self.count > maxSize {
            self = self.subString(start: 0, length: maxSize)
        }
    }
    
}
