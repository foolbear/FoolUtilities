//
//  FoolDBManager.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/3/16.
//

import Foundation
import CoreData

@available(iOS 13.0, OSX 11.0, *)
public class FoolDBManager: ObservableObject {
    public static let shared = FoolDBManager()
    var containerName = ""
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    public var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    private init() {}
    
    public func setup(_ containerName: String) {
        self.containerName = containerName
    }
    
    public func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                foolPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public class func execute(_ block: @escaping () -> Void) {
        block()
        FoolDBManager.shared.save()
    }
}
