//
//  DayRecordsManager.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/24/23.
//

import Foundation
import CoreData

class DayRecordsManager {
    
    static let shared = DayRecordsManager()
    
    private init() { }
    
    let coreDataManager = CoreDataManager.shared
    
}


// MARK: CREATE
extension DayRecordsManager {
    func addDayRecord(_ dayRecord: DayRecord) {
        let context = coreDataManager.persistentContainer.viewContext
        let newDayRecord = DayRecords(context: context)
        
        newDayRecord.date = dayRecord.date
        newDayRecord.sleepingTime = Int16(dayRecord.sleepingTime)
        newDayRecord.popularEffect = try? JSONEncoder().encode(dayRecord.popularEffect)
        newDayRecord.dangerEffect = try? JSONEncoder().encode(dayRecord.dangerEffect)
        newDayRecord.weight = dayRecord.weight
        newDayRecord.activity = try? JSONEncoder().encode(dayRecord.acitivty)
        newDayRecord.amountOfSmoking = Int16(dayRecord.amountOfSmoking)
        newDayRecord.amountOfCaffein = Int16(dayRecord.amountOfCaffein)
        newDayRecord.isPeriod = dayRecord.isPeriod
        newDayRecord.amountOfAlcohol = Int16(dayRecord.amountOfAlcohol)
        newDayRecord.memo = dayRecord.memo
        newDayRecord.conditionValues = try? JSONEncoder().encode(dayRecord.conditionValues)
        newDayRecord.moodValues = try? JSONEncoder().encode(dayRecord.moodValues)
        
        coreDataManager.saveContext()
        print("CoreData::: 데일리 기록 저장")
    }
        
    func saveDayRecord(_ dayRecord: DayRecord) {
        let context = coreDataManager.persistentContainer.viewContext

        // Fetch request to check if a record with the same date already exists
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", dayRecord.date as CVarArg)

        do {
            let existingRecords = try context.fetch(fetchRequest)

            // If an existing record is found, delete it
            if let existingRecord = existingRecords.first {
                context.delete(existingRecord)
                print("CoreData::: 기존 레코드 삭제됨")
            }
        } catch {
            print("CoreData::: 기존 레코드 조회 실패:", error)
        }

        // Create a new DayRecord
        let newDayRecord = DayRecords(context: context)
        
        newDayRecord.date = dayRecord.date
        newDayRecord.sleepingTime = Int16(dayRecord.sleepingTime)
        newDayRecord.popularEffect = try? JSONEncoder().encode(dayRecord.popularEffect)
        newDayRecord.dangerEffect = try? JSONEncoder().encode(dayRecord.dangerEffect)
        newDayRecord.weight = dayRecord.weight
        newDayRecord.activity = try? JSONEncoder().encode(dayRecord.acitivty)
        newDayRecord.amountOfSmoking = Int16(dayRecord.amountOfSmoking)
        newDayRecord.amountOfCaffein = Int16(dayRecord.amountOfCaffein)
        newDayRecord.isPeriod = dayRecord.isPeriod
        newDayRecord.amountOfAlcohol = Int16(dayRecord.amountOfAlcohol)
        newDayRecord.memo = dayRecord.memo
        newDayRecord.conditionValues = try? JSONEncoder().encode(dayRecord.conditionValues)
        newDayRecord.moodValues = try? JSONEncoder().encode(dayRecord.moodValues)
        
        coreDataManager.saveContext()

        print("CoreData::: 데일리 기록 저장")
    }
}

//MARK: READ
extension DayRecordsManager {
    func fetchDayRecord(for date: Date) -> DayRecord? {
        
        let startDate = Calendar.current.startOfDay(for: date)
        let context = coreDataManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)

        do {
            let records = try context.fetch(fetchRequest)
            // Return the first record if found, otherwise nil
            guard let entity = records.first else { return nil }
            guard let date = entity.date,
                  let popularEffectData = entity.popularEffect,
                  let dangerEffectData = entity.dangerEffect,
                  let conditionValuesData = entity.conditionValues,
                  let moodValuesData = entity.moodValues,
                  let acitivityData = entity.activity,
                  let activity = try? JSONDecoder().decode([Activity].self, from: acitivityData),
                  let popularEffect = try? JSONDecoder().decode([SideEffects.Major].self, from: popularEffectData),
                  let dangerEffect = try? JSONDecoder().decode([SideEffects.Dangerous].self, from: dangerEffectData),
                  let conditionValues = try? JSONDecoder().decode([Double].self, from: conditionValuesData),
                  let moodValues = try? JSONDecoder().decode([Double].self, from: moodValuesData) else {
                return nil
                print("CoreData 레코드 조회 성공")
            }
            
            return DayRecord(
                date: date,
                conditionValues: conditionValues,
                moodValues: moodValues,
                sleepingTime: Int(entity.sleepingTime),
                popularEffect: popularEffect,
                dangerEffect: dangerEffect,
                weight: entity.weight,
                acitivty: activity,
                amountOfSmoking: Int(entity.amountOfSmoking),
                amountOfCaffein: Int(entity.amountOfCaffein),
                isPeriod: entity.isPeriod,
                amountOfAlcohol: Int(entity.amountOfAlcohol),
                memo: entity.memo ?? ""
            )
            
        } catch {
            print("CoreData 레코드 조회 실패:", error)
            return nil
        }
    }
    
    func fetchDayRecords(from: Date, to: Date) -> [Date: DayRecord]? {
        let context = coreDataManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()

        let startOfDay = Calendar.current.startOfDay(for: from)
        let endOfDay = Calendar.current.startOfDay(for: to)
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfDay as CVarArg, endOfDay as CVarArg)

        do {
            let records = try context.fetch(fetchRequest)
            var dayRecordsDict = [Date: DayRecord]()

            for entity in records {
                guard let date = entity.date,
                      let popularEffectData = entity.popularEffect,
                      let dangerEffectData = entity.dangerEffect,
                      let conditionValuesData = entity.conditionValues,
                      let moodValuesData = entity.moodValues,
                      let acitivityData = entity.activity,
                      let activity = try? JSONDecoder().decode([Activity].self, from: acitivityData),
                      let popularEffect = try? JSONDecoder().decode([SideEffects.Major].self, from: popularEffectData),
                      let dangerEffect = try? JSONDecoder().decode([SideEffects.Dangerous].self, from: dangerEffectData),
                      let conditionValues = try? JSONDecoder().decode([Double].self, from: conditionValuesData),
                      let moodValues = try? JSONDecoder().decode([Double].self, from: moodValuesData) else {
                    continue
                }

                let dayRecord = DayRecord(
                    date: date,
                    conditionValues: conditionValues,
                    moodValues: moodValues,
                    sleepingTime: Int(entity.sleepingTime),
                    popularEffect: popularEffect,
                    dangerEffect: dangerEffect,
                    weight: entity.weight,
                    acitivty: activity,
                    amountOfSmoking: Int(entity.amountOfSmoking),
                    amountOfCaffein: Int(entity.amountOfCaffein),
                    isPeriod: entity.isPeriod,
                    amountOfAlcohol: Int(entity.amountOfAlcohol),
                    memo: entity.memo ?? ""
                )

                dayRecordsDict[date] = dayRecord
            }

            return dayRecordsDict
            
        } catch {
            print("CoreData 레코드 조회 실패:", error)
            return nil
        }
    }

    
    func fetchAllDayRecords() -> [DayRecord] {
        let context = coreDataManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        
        do {
            let dayRecordsEntities = try context.fetch(fetchRequest)
            return dayRecordsEntities.compactMap { entity -> DayRecord? in
                guard let date = entity.date,
                      let popularEffectData = entity.popularEffect,
                      let dangerEffectData = entity.dangerEffect,
                      let conditionValuesData = entity.conditionValues,
                      let moodValuesData = entity.moodValues,
                      let acitivityData = entity.activity,
                      let activity = try? JSONDecoder().decode([Activity].self, from: acitivityData),
                      let popularEffect = try? JSONDecoder().decode([SideEffects.Major].self, from: popularEffectData),
                      let dangerEffect = try? JSONDecoder().decode([SideEffects.Dangerous].self, from: dangerEffectData),
                      let conditionValues = try? JSONDecoder().decode([Double].self, from: conditionValuesData),
                      let moodValues = try? JSONDecoder().decode([Double].self, from: moodValuesData) else {
                    return nil
                }
                return DayRecord(
                    date: date,
                    conditionValues: conditionValues,
                    moodValues: moodValues,
                    sleepingTime: Int(entity.sleepingTime),
                    popularEffect: popularEffect,
                    dangerEffect: dangerEffect,
                    weight: entity.weight,
                    acitivty: activity,
                    amountOfSmoking: Int(entity.amountOfSmoking),
                    amountOfCaffein: Int(entity.amountOfCaffein),
                    isPeriod: entity.isPeriod,
                    amountOfAlcohol: Int(entity.amountOfAlcohol),
                    memo: entity.memo ?? ""
                )
            }
        } catch {
            print("Failed to fetch day records: \(error.localizedDescription)")
            return []
        }
    }
}

//MARK: UPDATE
extension DayRecordsManager {
    func updateSpecificDayRecord(date: Date, fieldKey: String, newValue: Any) {
        let dayStart = Calendar.current.startOfDay(for: date)
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", dayStart as NSDate)
        
        do {
            let context = coreDataManager.persistentContainer.viewContext
            let results = try context.fetch(fetchRequest)
            if let existingRecord = results.first {
                existingRecord.setValue(newValue, forKey: fieldKey)
                coreDataManager.saveContext()
            }
        } catch {
            print("Core Data 업데이트 실패: \(error)")
        }
    }
    
    // 전체 수정
    func updateDayRecord(_ dayRecord: DayRecord) {
        let context = coreDataManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", dayRecord.date as NSDate)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingRecord = results.first {
                existingRecord.conditionValues = try? JSONEncoder().encode(dayRecord.conditionValues)
                existingRecord.moodValues = try? JSONEncoder().encode(dayRecord.moodValues)
                existingRecord.sleepingTime = Int16(dayRecord.sleepingTime)
                existingRecord.popularEffect = try? JSONEncoder().encode(dayRecord.popularEffect)
                existingRecord.dangerEffect = try? JSONEncoder().encode(dayRecord.dangerEffect)
                existingRecord.weight = dayRecord.weight
                existingRecord.activity = try? JSONEncoder().encode(dayRecord.acitivty)
                existingRecord.amountOfSmoking = Int16(dayRecord.amountOfSmoking)
                existingRecord.amountOfCaffein = Int16(dayRecord.amountOfCaffein)
                existingRecord.isPeriod = dayRecord.isPeriod
                existingRecord.amountOfAlcohol = Int16(dayRecord.amountOfAlcohol)
                existingRecord.memo = dayRecord.memo
                // 기타 필요한 속성 업데이트
                
                coreDataManager.saveContext()
                print("업데이트 성공")
            } else {
                print("업데이트할 레코드를 찾을 수 없음")
            }
        } catch {
            print("레코드 업데이트 실패: \(error)")
        }
    }
}
