//
//  FoolCombine.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/12/22.
//

import SwiftUI
import Combine

@available(iOS 13.0, *)
public extension View {
    func delayPublisher(_ delay: TimeInterval) -> Future<Void, Never> {
        return Future() { promise in
            DispatchQueue.main.asyncAfter(deadline:.now() + delay) {
                promise(.success(()))
            }
        }
    }
}

@available(iOS 13.0, *)
public func debounceAndRemoveDuplicates<T: Equatable>(for publisher: Published<T>.Publisher, debounceDueTime dueTime: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(500), dropFirst: Bool = false) -> AnyPublisher<T, Never> {
    if dropFirst {
        return publisher
            .dropFirst()
            .debounce(for: dueTime, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    } else {
        return publisher
            .debounce(for: dueTime, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
