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
    func createEmptyTakens() {
        let startDate = Calendar.current.startOfDay(for: Date())

        let context = coreDataManager.persistentContainer.viewContext

        // Fetch request to check if a record with the same date already exists
        
        let fetchRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)

        do {
            let existingRecords = try context.fetch(fetchRequest)

            guard existingRecords.count == 0 else {
                print("coredata:: takens already exist")
                print(existingRecords)
                return
            }
            let newDayRecord = Takens(context: context)
            newDayRecord.date = startDate
            newDayRecord.id = UUID()
            let history:[HistoryModel] = []
            newDayRecord.history = try? JSONEncoder().encode(history)
            coreDataManager.saveContext()
            print("create")
        } catch {
            print("CoreData::: Takens 조회 실패:", error)
        }
    }
      
}


//MARK: READ
extension TakensManager {
    func fetch(date: Date) -> Result<[HistoryModel],Status> {
        let startDate = Calendar.current.startOfDay(for: date)

        let context = coreDataManager.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)

        do {
            let results = try context.fetch(fetchRequest)

            guard let result = results.first,
                  let historyData = result.history,
                  var history = try? JSONDecoder().decode([HistoryModel].self, from: historyData)
            else {
                return Result.failure(.none)
            }
            let successResult = history.map {
                HistoryModel(id: $0.id, capacity: $0.capacity, name: $0.name, settingTime: $0.settingTime, timeTaken: $0.timeTaken, unit: $0.unit)
            }
            return Result.success(successResult)
        } catch {
            print("CoreData::: Takens 조회 실패:", error)
            return Result.failure(.fail)
        }
    }
}

//MARK: UPDATE
extension TakensManager {
    func check(date: Date, historyModel: HistoryModel) -> Status {
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
                return .fail
            }
            
            if let index = history.firstIndex(where: { $0.id == historyModel.id }) {
                history.remove(at: index)

            } else {
                history.append(historyModel)
            }
                
            result.setValue(history, forKey: "history")
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
