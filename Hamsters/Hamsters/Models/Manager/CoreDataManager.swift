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
    
    // MARK: - 약물 설정 관련 코어데이터 CRUD
    func updateMedicine(_ medicine: Medicine) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Medicines> = Medicines.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", medicine.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingMedicine = results.first {
                // 속성 업데이트
                existingMedicine.name = medicine.name
                existingMedicine.capacity = medicine.capacity
                existingMedicine.unit = medicine.unit
                existingMedicine.frequency = try? JSONEncoder().encode(medicine.frequency)
                existingMedicine.alarms = try? JSONEncoder().encode(medicine.alarms)
                existingMedicine.freOption = medicine.freOption.rawValue
                existingMedicine.sortedDays = medicine.sortedDays
                // 컨텍스트 저장
                try context.save()
                print("업데이트 성공")
            } else {
                print("업데이트할 약물을 찾을 수 없음")
            }
        } catch {
            print("약물 업데이트 실패: \(error)")
        }
    }
    
    func addMedicine(_ medicine: Medicine) {
        let context = persistentContainer.viewContext
        let newMedicine = Medicines(context: context)
        
        newMedicine.id = medicine.id
        newMedicine.name = medicine.name
        newMedicine.capacity = medicine.capacity
        newMedicine.unit = medicine.unit
        newMedicine.frequency = try? JSONEncoder().encode(medicine.frequency)
//        newMedicine.alarms = try? JSONEncoder().encode([medicine.alarms])
        newMedicine.alarms = try? JSONEncoder().encode(medicine.alarms)
        newMedicine.freOption = medicine.freOption.rawValue
        newMedicine.sortedDays = medicine.sortedDays
        saveContext()
        print("CoreData::: 투여약 저장")
        
    }
    
    func fetchAllMedicines() -> [Medicine] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Medicines> = Medicines.fetchRequest()
        
        do {
            let medicinesEntities = try context.fetch(fetchRequest)
            return medicinesEntities.compactMap { entity -> Medicine? in
                // Entity를 Medicine 구조체로 변환
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
        } catch {
            print("Failed to fetch medicines: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteMedicine(_ medicine: Medicine, completion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Medicines> = Medicines.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", medicine.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingMedicine = results.first {
                context.delete(existingMedicine)
                try context.save()
                completion?()
                print("삭제 성공")
            } else {
                print("해당하는 약물을 찾을 수 없음")
            }
        } catch {
            print("약물 삭제 실패: \(error)")
        }
    }
    
    // MARK: - 하루 기록 코어데이터 CRUD
    
    func addDayRecord(_ dayRecord: DayRecord) {
        let context = persistentContainer.viewContext
        let newDayRecord = DayRecords(context: context)
        
        newDayRecord.date = dayRecord.date
        newDayRecord.sleepingTime = Int16(dayRecord.sleepingTime)
        newDayRecord.popularEffect = try? JSONEncoder().encode(dayRecord.popularEffect)
        newDayRecord.dangerEffect = try? JSONEncoder().encode(dayRecord.dangerEffect)
        newDayRecord.weight = dayRecord.weight
        newDayRecord.amountOfSmoking = Int16(dayRecord.amountOfSmoking)
        newDayRecord.amountOfCaffein = Int16(dayRecord.amountOfCaffein)
        newDayRecord.isPeriod = dayRecord.isPeriod
        newDayRecord.amountOfAlcohol = Int16(dayRecord.amountOfAlcohol)
        newDayRecord.memo = dayRecord.memo
        newDayRecord.conditionValues = try? JSONEncoder().encode(dayRecord.conditionValues)
        newDayRecord.moodValues = try? JSONEncoder().encode(dayRecord.moodValues)
        
        saveContext()
        print("CoreData::: 데일리 기록 저장")
    }
    
    func fetchAllDayRecords() -> [DayRecord] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        
        do {
            let dayRecordsEntities = try context.fetch(fetchRequest)
            return dayRecordsEntities.compactMap { entity -> DayRecord? in
                guard let date = entity.date,
                      let popularEffectData = entity.popularEffect,
                      let dangerEffectData = entity.dangerEffect,
                      let conditionValuesData = entity.conditionValues,
                      let moodValuesData = entity.moodValues,
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
    
    // dayrecord 각각 수정
    func updateSpecificDayRecord(date: Date, fieldKey: String, newValue: Any) {
        let dayStart = startOfDay(for: date)
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", dayStart as NSDate)
        
        do {
            let context = persistentContainer.viewContext
            let results = try context.fetch(fetchRequest)
            if let existingRecord = results.first {
                existingRecord.setValue(newValue, forKey: fieldKey)
                saveContext()
            }
        } catch {
            print("Core Data 업데이트 실패: \(error)")
        }
    }
    
    // 전체 수정
    func updateDayRecord(_ dayRecord: DayRecord) {
        let context = persistentContainer.viewContext
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
                existingRecord.amountOfSmoking = Int16(dayRecord.amountOfSmoking)
                existingRecord.amountOfCaffein = Int16(dayRecord.amountOfCaffein)
                existingRecord.isPeriod = dayRecord.isPeriod
                existingRecord.amountOfAlcohol = Int16(dayRecord.amountOfAlcohol)
                existingRecord.memo = dayRecord.memo
                // 기타 필요한 속성 업데이트
                
                saveContext()
                print("업데이트 성공")
            } else {
                print("업데이트할 레코드를 찾을 수 없음")
            }
        } catch {
            print("레코드 업데이트 실패: \(error)")
        }
    }
    
    func startOfDay(for date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
}

extension CoreDataManager {
    
    func saveDayRecord(_ dayRecord: DayRecord) {
        let context = persistentContainer.viewContext

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
        newDayRecord.amountOfSmoking = Int16(dayRecord.amountOfSmoking)
        newDayRecord.amountOfCaffein = Int16(dayRecord.amountOfCaffein)
        newDayRecord.isPeriod = dayRecord.isPeriod
        newDayRecord.amountOfAlcohol = Int16(dayRecord.amountOfAlcohol)
        newDayRecord.memo = dayRecord.memo
        newDayRecord.conditionValues = try? JSONEncoder().encode(dayRecord.conditionValues)
        newDayRecord.moodValues = try? JSONEncoder().encode(dayRecord.moodValues)
        
        saveContext()

        print("CoreData::: 데일리 기록 저장")
    }

    
    func fetchDayRecord(for date: Date) -> DayRecord? {
        
        let startDate = Calendar.current.startOfDay(for: date)
        let context = persistentContainer.viewContext
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

}
