//
//  FoolSelector.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/3/4.
//

import Foundation

@available(iOS 13, *)
public class FoolSelector<T: Identifiable & Hashable>: ObservableObject {
    @Published public var selection: Set<T> = Set<T>()
    public var count: Int { selection.count }
    
    public func isSelected(_ item: T) -> Bool {
        return selection.filter { $0.id == item.id }.count != 0
    }
    
    public func insert(_ item: T) {
        selection.insert(item)
    }
    
    public func remove(_ item: T) {
        selection = selection.filter { $0.id != item.id }
    }
    
    public func removeAll() {
        selection.removeAll()
    }
}
