//
//  FoolArray.swift
//  FoolUtilities
//
//  Created by foolbear on 2021/1/2.
//

import Foundation

public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter { uniq.insert($0).inserted }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
