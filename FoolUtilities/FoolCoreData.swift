//
//  FoolCoreData.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/12/10.
//

import SwiftUI
import CoreData

@available(iOS 13.0, OSX 11.0, *)
public struct FoolFetchView<T: NSManagedObject, Content: View>: View {
    let fetchRequest: FetchRequest<T>
    let content: (FetchedResults<T>) -> Content

    public var body: some View {
        self.content(fetchRequest.wrappedValue)
    }

    public init(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate, animation: .default)
        self.content = content
    }

    public init(fetchRequest: NSFetchRequest<T>, @ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        self.fetchRequest = FetchRequest<T>(fetchRequest: fetchRequest)
        self.content = content
    }
}

public extension NSManagedObjectContext {
    func saveChanges() {
        guard self.hasChanges else { return }
        do {
            try self.save()
        } catch {
            let error = error as NSError
            foolPrint("Unresolved error: \(error), \(error.userInfo)")
        }
    }
}
