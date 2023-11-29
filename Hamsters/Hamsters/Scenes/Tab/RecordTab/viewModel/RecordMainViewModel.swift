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
    @Published var datesOnRecord: [String] = []
    @Published var recordStatus: RecordStatus = .noRecord
    
    @Published var selectedDate: Date = Date()

    private let startDateString = UserDefaults.standard.string(forKey: UserDefaultsKey.startDate.rawValue)

    private let takensController: NSFetchedResultsController<Takens>
    private let medicinesController: NSFetchedResultsController<Medicines>
    private let dayRecordsController: NSFetchedResultsController<DayRecords>

    private let context: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    override init() {
        let fetchTakensRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchTakensRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Takens.date, ascending: true)]
//        let startDate = Calendar.current.startOfDay(for: Date())
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
        
        
        let dayRecordsfetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        dayRecordsfetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \DayRecords.date, ascending: true)]
//        fetchRequest.predicate = NSPredicate(format: "date == %@", Date() as CVarArg)

        dayRecordsController = NSFetchedResultsController(
            fetchRequest: dayRecordsfetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        
        takensController.delegate = self
        medicinesController.delegate = self
        dayRecordsController.delegate = self

        do {
            try takensController.performFetch()
            try medicinesController.performFetch()
            try dayRecordsController.performFetch()
            update()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
}

extension RecordMainViewModel {

    private func update() {
        print("RecordMainViewModel:: 델리게이트 UPDATE")
        let today = Date()
        TakensManager.shared.createEmptyTakens(date: today)
        
        guard
            let fetcheMedicines = MedicinesManager.shared.fetchAllMedicines(),
            let fetchedHistory = TakensManager.shared.fetchHistory(date: today)
        else {
            return
        }
        
        let weekday = Calendar.current.component(.weekday, from: today)
        
        let result = fetcheMedicines
            .compactMap { medicine -> [MedicineSchedule]? in
                if let _ = medicine.frequency.firstIndex(where: { $0.num == weekday}), medicine.alarms.count > 0 {
                    
                    return medicine.alarms.map { alarm in
                        let isTaken = fetchedHistory.filter { $0.id == alarm.id }.count > 0 ? true : false
                        return MedicineSchedule(id: alarm.id, capacity: medicine.capacity, name: medicine.name, unit: medicine.unit, settingTime: alarm.date, isTaken: isTaken, scheduleType: is235959(alarm.date) ? .necessary : .specific)
                    }
                }
                
                return nil
            }
            .flatMap { $0 }
            .sorted{ compareTimeOnly(date1: $0.settingTime, date2: $1.settingTime) }
        
        medicineSchedule = result
        loadDates()
        print("update success")
    }
    
    private func loadDates() {
        let today = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: today) ?? Date()   // 일주일치만 조회
        
        let recordDatesDict = DayRecordsManager.shared.fetchDayRecords(from: startDate, to: today)
        
        if let recordDatesDict = recordDatesDict {
            datesOnRecord = recordDatesDict.compactMap{ $0.0.basicDash }
        } else {
            datesOnRecord = []
        }
        
        if datesOnRecord.contains(today.basicDash) {
            recordStatus = .record
        }
    }
    
    func takeMedicine(_ medicine: MedicineSchedule) {
        let now = Date()

        let historyModel = HistoryModel(id: medicine.id, capacity: medicine.capacity, name: medicine.name, settingTime: medicine.settingTime, timeTaken: now, unit: medicine.unit)
    
        _ = TakensManager.shared.updateHistory(date: now, historyModel: historyModel)
    }
    
    func compareTimeOnly(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current

        let components1 = calendar.dateComponents([.hour, .minute], from: date1)
        let components2 = calendar.dateComponents([.hour, .minute], from: date2)

        return (components1.hour! * 60 + components1.minute!) < (components2.hour! * 60 + components2.minute!)
    }
    
    func is235959(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)

        return components.hour == 23 && components.minute == 59 && components.second == 59
    }
}

extension RecordMainViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        update()
    }
    
    enum Status {
        case exist
        case none
    }
}
