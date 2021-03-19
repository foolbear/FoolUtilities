//
//  FoolSnapshot.swift
//  FoolUtilities
//
//  Created by foolbear on 2021/3/18.
//

import SwiftUI

@available(iOS 13.0, OSX 11.0, *)
public extension View {
    func foolSnapshot(_ size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = size
//        let targetSize = controller.view.intrinsicContentSize
        
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
