//
//  DummyManager.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/23/23.
//

import Foundation


class DummyManager {
    static let shared = DummyManager()
    let coreDataManager = CoreDataManager.shared
    
    func insertMedicine() {
        var newMedicine: Medicine
        newMedicine = Medicine(name: "콘서타 - 월화수",
                                   capacity: "30",
                                   unit: "정",
                                   frequency: [.monday,.tuesday,.wednesday],
                                   alarms: [AlarmItem(date: Date(), isEnabled: true),AlarmItem(date: Date(), isEnabled: true)],
                                   freOption: .specificDay,
                                   sortedDays: "sortedDays")
        
        coreDataManager.addMedicine(newMedicine)
        
        newMedicine = Medicine(name: "콘서타- 매일",
                                   capacity: "30",
                                   unit: "정",
                               frequency: [.monday,.tuesday,.wednesday,.thursday,.friday,.saturday,.sunday],
                                   alarms: [AlarmItem(date: Date(), isEnabled: true),AlarmItem(date: Date(), isEnabled: true)],
                                    freOption: .everyDay,
                                   sortedDays: "sortedDays")
        
        coreDataManager.addMedicine(newMedicine)
        
        newMedicine = Medicine(name: "콘서타 - 목",
                                   capacity: "30",
                                   unit: "정",
                               frequency: [.thursday,.friday,.saturday,.sunday],
                                   alarms: [AlarmItem(date: Date(), isEnabled: true),AlarmItem(date: Date(), isEnabled: true)],
                               freOption: .specificDay,
                                   sortedDays: "sortedDays")
        
        coreDataManager.addMedicine(newMedicine)
    }
    
    func insertHistory() {
        let hm = HistoryModel(id: UUID(), capacity: "C", name: "NAME", settingTime: Date(), timeTaken: Date(), unit: "정")
        
    }
}
