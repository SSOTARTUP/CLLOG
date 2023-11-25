//
//  CoreDataManager.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/13/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Coredata erorr: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Coredata save error: \(error.localizedDescription)")
            }
        }
    }
    
    func startOfDay(for date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
}

