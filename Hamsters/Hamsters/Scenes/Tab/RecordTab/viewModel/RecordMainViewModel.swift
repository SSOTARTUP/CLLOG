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
    @Published var histories: [HistoryModel] = []

    private let takensController: NSFetchedResultsController<Takens>
    private let medicinesController: NSFetchedResultsController<Medicines>
    
    private let context: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    override init() {
        let fetchTakensRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchTakensRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Takens.date, ascending: true)]
        let startDate = Calendar.current.startOfDay(for: Date())
        fetchTakensRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)
        
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
          //  updateHistories()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
}

extension RecordMainViewModel {
    
    private func fetchMedicines() -> [Medicine]? {
        guard let fetchedMedicines = medicinesController.fetchedObjects else { return nil }
        
        let result = fetchedMedicines.compactMap { entity -> Medicine? in
            guard let id = entity.id,
                  let name = entity.name,
                  let capacity = entity.capacity,
                  let unit = entity.unit,
                  let frequencyData = entity.frequency,
                  let alarmsData = entity.alarms,
                  let frequency = try? JSONDecoder().decode([Day].self, from: frequencyData),
                  let alarms = try? JSONDecoder().decode([AlarmItem].self, from: alarmsData),
                  let freOptionString = entity.freOption,
                  let freOption = Option(rawValue: freOptionString),
                  let sortedDays = entity.sortedDays else {
                return nil
            }
            return Medicine(
                id: id,
                name: name,
                capacity: capacity,
                unit: unit,
                frequency: frequency,
                alarms: alarms,
                freOption: freOption,
                sortedDays: sortedDays
            )
        }
        
        return result
    }
    

    private func updateHistories() {
        let fetcheMedicines = fetchMedicines()
        let history = TakensManager.shared.fetchHistory(date: Date())
        print(history)
    }
}
extension RecordMainViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateHistories()
    }
}
