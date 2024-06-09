//
//  CoreDataStack.swift
//  NutritionViewer
//
//  Created by Aryan Sinha on 08/10/23.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() { }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Nutrition")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

