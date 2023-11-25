//
//  RecordMainViewModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/23/23.
//

import Foundation
import SwiftUI
import CoreData

class RecordMainViewModel: NSObject, ObservableObject {
    @Published var medicineSchedule: [MedicineSchedule] = []

    private let takensController: NSFetchedResultsController<Takens>
    private let medicinesController: NSFetchedResultsController<Medicines>
    
    private let context: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    override init() {
        let fetchTakensRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchTakensRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Takens.date, ascending: true)]
        let startDate = Calendar.current.startOfDay(for: Date())
//        fetchTakensRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)
        
        takensController = NSFetchedResultsController(
            fetchRequest: fetchTakensRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        let fetchRequest2: NSFetchRequest<Medicines> = Medicines.fetchRequest()
        fetchRequest2.sortDescriptors = [NSSortDescriptor(keyPath: \Medicines.name, ascending: true)]
        
        medicinesController = NSFetchedResultsController(
            fetchRequest: fetchRequest2,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        takensController.delegate = self
        medicinesController.delegate = self

        do {
            try takensController.performFetch()
            try medicinesController.performFetch()
            update()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
}

extension RecordMainViewModel {

    private func update() {
        print("RecordMainViewModel:: UPDATE")
        let today = Date()

        guard
            let fetcheMedicines = MedicinesManager.shared.fetchAllMedicines(),
            let fetchedHistory = TakensManager.shared.fetchHistory(date: today)
        else { return }
        let weekday = Calendar.current.component(.weekday, from: today)
        
        let result = fetcheMedicines
            .compactMap { medicine -> [MedicineSchedule]? in
                if let _ = medicine.frequency.firstIndex(where: { $0.num == weekday}), medicine.alarms.count > 0 {
                    
                    return medicine.alarms.map { alarm in
                        let isTaken = fetchedHistory.filter { $0.id == alarm.id }.count > 0 ? true : false
                        return MedicineSchedule(id: alarm.id, capacity: medicine.capacity, name: medicine.name, unit: medicine.unit, settingTime: alarm.date, isTaken: isTaken)
                    }
                }
                return nil
            }
            .flatMap { $0 }
            .sorted{ compareTimeOnly(date1: $0.settingTime, date2: $1.settingTime) }
        
        medicineSchedule = result
    }
    
    func compareTimeOnly(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current

        let components1 = calendar.dateComponents([.hour, .minute], from: date1)
        let components2 = calendar.dateComponents([.hour, .minute], from: date2)

        return (components1.hour! * 60 + components1.minute!) < (components2.hour! * 60 + components2.minute!)
    }
}

extension RecordMainViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        update()
    }
}
