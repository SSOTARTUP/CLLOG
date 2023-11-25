//
//  File.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/23/23.
//

import Foundation
import CoreData

class TakensManager {
    static let shared = TakensManager()
    
    private init() {}
    
    let coreDataManager = CoreDataManager.shared
    
}

//MARK: CREATE
extension TakensManager {
    func createEmptyTakens(date: Date) {
        let startDate = Calendar.current.startOfDay(for: date)

        let context = coreDataManager.persistentContainer.viewContext

        // Fetch request to check if a record with the same date already exists
        
        let fetchRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)

        do {
            let existingRecords = try context.fetch(fetchRequest)

            guard existingRecords.count == 0 else {
                print("coredata:: takens already exist")
                return
            }
            let newDayRecord = Takens(context: context)
            newDayRecord.date = startDate
            newDayRecord.id = UUID()
            let history:[HistoryModel] = []
            newDayRecord.history = try? JSONEncoder().encode(history)
            coreDataManager.saveContext()
        } catch {
            print("CoreData::: Takens 조회 실패:", error)
        }
    }
      
}


//MARK: READ
extension TakensManager {
    func fetchHistory(date: Date) -> [HistoryModel]? {
        let startDate = Calendar.current.startOfDay(for: date)

        let context = coreDataManager.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)

        do {
            let results = try context.fetch(fetchRequest)
            guard let result = results.first,
                  let historyData = result.history,
                  let history = try? JSONDecoder().decode([HistoryModel].self, from: historyData)
            else {
                return nil
            }
            let successResult = history.map {
                HistoryModel(id: $0.id, capacity: $0.capacity, name: $0.name, settingTime: $0.settingTime, timeTaken: $0.timeTaken, unit: $0.unit)
            }
            return successResult
        } catch {
            print("CoreData::: Takens 조회 실패:", error)
            return nil
        }
    }
    
    // 테스트 필요.
    func fetchHistory(from startDate: Date, to endDate: Date) -> [Date: [HistoryModel]]? {
        let context = coreDataManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        
        let startOfDay = Calendar.current.startOfDay(for: startDate)
        let endOfDay = Calendar.current.startOfDay(for: endDate)
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfDay as CVarArg, endOfDay as CVarArg)

        do {
            let results = try context.fetch(fetchRequest)

            var historyByDate = [Date: [HistoryModel]]()
            for takens in results {
                guard let date = takens.date, let historyData = takens.history else { continue }
                if let historyModels = try? JSONDecoder().decode([HistoryModel].self, from: historyData) {
                    historyByDate[date] = historyModels
                }
            }
            
            return historyByDate
        } catch {
            print("CoreData::: Takens 조회 실패:", error)
            return nil
        }
    }


}

//MARK: UPDATE
extension TakensManager {
    func updateHistory(date: Date, historyModel: HistoryModel) -> Status {
        createEmptyTakens(date: date)
        let startDate = Calendar.current.startOfDay(for: date)
        let fetchRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", startDate as NSDate)
        
        do {
            let context = coreDataManager.persistentContainer.viewContext
            let results = try context.fetch(fetchRequest)
            guard
                let result = results.first,
                let historyData = result.history,
                var history = try? JSONDecoder().decode([HistoryModel].self, from: historyData)
            else {
                print("fail")
                return .fail
            }
            
            if let index = history.firstIndex(where: { $0.id == historyModel.id }) {
                history.remove(at: index)
                print("TakensManager:: check disabled")
            } else {
                history.append(historyModel)
                print("TakensManager:: check activated")
            }
            guard let encodedHistory =  try? JSONEncoder().encode(history) else {
                return .fail
            }
            result.setValue(encodedHistory, forKey: "history")
            coreDataManager.saveContext()
            
            return .success
        } catch {
            print("Core Data 업데이트 실패: \(error)")
            return .fail
        }
    }
}


extension TakensManager {
    enum Status: Error {
        case success
        case fail
        case none
    }
}
