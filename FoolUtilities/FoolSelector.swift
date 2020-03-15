//
//  FoolSelector.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/3/4.
//

import Foundation

@available(iOS 13.0, *)
public typealias FoolSelector<T> = Set<T> where T: Identifiable & Hashable

@available(iOS 13.0, *)
public extension Set where Element: Identifiable {
    @inlinable func isSelected(_ item: Element) -> Bool {
        return self.filter { $0.id == item.id }.count != 0
    }
    
    @inlinable mutating func select(_ item: Element) {
        self.insert(item)
    }
    
    @inlinable mutating func selectAll(_ items: Set<Element>) {
        self = items
    }
    
    @inlinable mutating func unselect(_ item: Element) {
        self = self.filter { $0.id != item.id }
    }
    
    @inlinable mutating func unselectAll() {
        self.removeAll()
    }
    
    @inlinable mutating func toggle(_ item: Element) {
        if isSelected(item) {
            unselect(item)
        } else {
            select(item)
        }
    }
}
