//
//  MedicinesManager.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/23/23.
//

import Foundation
import CoreData

class MedicinesManager {
    static let shared = MedicinesManager()
    
    private init() {}
    
    let coreDataManager = CoreDataManager.shared
}

//MARK: CREATE
extension MedicinesManager {
    func addMedicine(_ medicine: Medicine) {
        let context = coreDataManager.persistentContainer.viewContext
        let newMedicine = Medicines(context: context)
        
        newMedicine.id = medicine.id
        newMedicine.name = medicine.name
        newMedicine.capacity = medicine.capacity
        newMedicine.unit = medicine.unit
        newMedicine.frequency = try? JSONEncoder().encode(medicine.frequency)
//        newMedicine.alarms = try? JSONEncoder().encode([medicine.alarms])
        newMedicine.freOption = medicine.freOption.rawValue
        newMedicine.sortedDays = medicine.sortedDays
        if medicine.sortedDays == "필요 시"{
            let calendar = Calendar.current
            let todayMidnight = calendar.startOfDay(for: Date())
            var components = DateComponents()
            components.hour = 23
            components.minute = 59
            components.second = 59
            let finalDate = calendar.date(byAdding: components, to: todayMidnight)!
            newMedicine.alarms = try? JSONEncoder().encode([AlarmItem(id: UUID(), date: finalDate, isEnabled: false)])
        } else {
            newMedicine.alarms = try? JSONEncoder().encode(medicine.alarms)
        }

        coreDataManager.saveContext()
        print("CoreData::: 투여약 저장")
    }
}

//MARK: READ
extension MedicinesManager {
    func fetchAllMedicines() -> [Medicine]? {
        let context = coreDataManager.persistentContainer.viewContext
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
            return nil
        }
    }
}

//MARK: UPDATE
extension MedicinesManager {
    func updateMedicine(_ medicine: Medicine) {
        let context = coreDataManager.persistentContainer.viewContext
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
}

//MARK: DELETE
extension MedicinesManager {
    func deleteMedicine(_ medicine: Medicine, completion: (() -> Void)? = nil) {
        let context = coreDataManager.persistentContainer.viewContext
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
}

