//
//  FoolView.swift
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
