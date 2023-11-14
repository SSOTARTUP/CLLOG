//
//  MedicineViewModel.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/18/23.
//

import Foundation

class MedicineViewModel: ObservableObject {
    @Published var medicines: [Medicine] = []
    
    // 필요한 프로퍼티를 ObservableObject로 선언합니다.
    @Published var medicineName: String = ""
    @Published var capacity: String = ""
    @Published var unit: String = "정"
    @Published var frequency: [Day] = []
    @Published var freOption: Option = .everyDay
    @Published var alarms: [AlarmItem] = [] // 알람 아이템의 구조체가 필요합니다.
    
    
    
    //        // Medicine 객체를 어딘가에 저장하거나 다른 처리를 합니다.
    //        // 예를 들어, 데이터베이스, Core Data, 서버 등에 객체를 저장할 수 있습니다.
    func addMedicine(name: String,
                     capacity: String,
                     frequency: [Day],
                     unit: String,
                     alarms: [AlarmItem],
                     freOption: Option,
                     sortedDays: String) {
        
        let newMedicine = Medicine(name: name,
                                   capacity: capacity,
                                   unit: unit,
                                   frequency: frequency,
                                   alarms: alarms,
                                   freOption: freOption,
                                   sortedDays: sortedDays)
        
        CoreDataManager.shared.addMedicine(newMedicine)
        medicines.append(newMedicine)
        print("Coredata :::: \(CoreDataManager.shared.fetchAllMedicines())")
    }
    
//    func deleteMedicine(at offsets: IndexSet) {
//        medicines.remove(atOffsets: offsets)
//    }
    func deleteMedicine(_ medicine: Medicine) {
        CoreDataManager.shared.deleteMedicine(medicine)
        if let index = medicines.firstIndex(where: { $0.id == medicine.id }) {
            medicines.remove(at: index)
        }
    }
    
    func updateMedicine(_ medicine: Medicine) {
        if let index = medicines.firstIndex(where: { $0.id == medicine.id}) {
            medicines[index] = medicine
            CoreDataManager.shared.updateMedicine(medicine)
        }
        print("UPdate :::: \(CoreDataManager.shared.fetchAllMedicines())")
    }
    
}

