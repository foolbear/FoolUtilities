//
//  FoolShareSheet.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/29.
//

#if !os(macOS)

import SwiftUI

@available(iOS 13.0, *)
public struct FoolShareSheet: UIViewControllerRepresentable {
    public typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
      
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?
    let excludedActivityTypes: [UIActivity.ActivityType]?
    let callback: Callback?
    
    public init(activityItems: [Any], applicationActivities: [UIActivity]? = nil, excludedActivityTypes: [UIActivity.ActivityType]? = nil, callback: Callback? = nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
        self.excludedActivityTypes = excludedActivityTypes
        self.callback = callback
    }
      
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
      
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#endif
