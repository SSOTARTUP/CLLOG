//
//  StatisticsMainViewModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/24/23.
//

import Foundation
import CoreData
import SwiftUI

class StatisticsMainViewModel: NSObject, ObservableObject {

    @Published var dayRecordsDic: [Date: DayRecord] = [:]
    @Published var medicineDic: [Date: [HistoryModel]] = [:]
       
    var interval: (from: Date, to :Date) = (from: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, to: Calendar.current.date(byAdding: .day, value: 0, to: Date())!) {
        didSet {
            interval = (from: Calendar.current.startOfDay(for: interval.from), to: Calendar.current.startOfDay(for: interval.to))
            update()
        }
    }
    
    private let takensController: NSFetchedResultsController<Takens>
    private let dayRecordsController: NSFetchedResultsController<DayRecords>
    
    private let context: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    override init() {
        print("@@@@@")
        let fetchTakensRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchTakensRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Takens.date, ascending: true)]
        
//        fetchTakensRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, endDate as CVarArg)

        takensController = NSFetchedResultsController(
            fetchRequest: fetchTakensRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        let fetchRequest2: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        fetchRequest2.sortDescriptors = [NSSortDescriptor(keyPath: \DayRecords.date, ascending: true)]
//        fetchRequest2.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, endDate as CVarArg)

        dayRecordsController = NSFetchedResultsController(
            fetchRequest: fetchRequest2,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        takensController.delegate = self
        dayRecordsController.delegate = self
        print("staticMainViewModel init")
        do {
            try takensController.performFetch()
            try dayRecordsController.performFetch()
            update()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
}

extension StatisticsMainViewModel {

    private func update() {
        print("StatisticsMainViewModel:: UPDATE")
        guard
            let fetcheDayRecords = DayRecordsManager.shared.fetchDayRecords(from: interval.from, to: interval.to),
            let fetchedHistory = TakensManager.shared.fetchHistory(from: interval.from, to: interval.to)
        else { return }
        
        dayRecordsDic = fetcheDayRecords
        medicineDic = fetchedHistory
    }
    
    func compareTimeOnly(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current

        let components1 = calendar.dateComponents([.hour, .minute], from: date1)
        let components2 = calendar.dateComponents([.hour, .minute], from: date2)

        return (components1.hour! * 60 + components1.minute!) < (components2.hour! * 60 + components2.minute!)
    }
}

extension StatisticsMainViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        update()
    }
}

