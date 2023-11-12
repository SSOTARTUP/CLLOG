//
//  MedicineModel.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/18/23.
//

import Foundation

struct Medicine: Identifiable {
    var id = UUID() // 고유 식별자
    var name: String // 약 이름
    var capacity: String  // 약의 용량 (e.g., "500", "250")
    var unit: String  // 약의 단위 (e.g., "mg", "mL")
    var frequency: [Day]  // 약을 복용할 요일
    var alarms: [AlarmItem]  // 설정된 알람들
    var freOption: Option
    var sortedDays: String
    
    // Medicine 인스턴스를 생성할 때 필요한 모든 정보를 채워 넣을 수 있도록 생성
    
    init(id: UUID = UUID(), name: String, capacity: String, unit: String, frequency: [Day], alarms: [AlarmItem], freOption: Option,sortedDays: String) {
        self.id = id
        self.name = name
        self.capacity = capacity
        self.unit = unit
        switch freOption {
        case .everyDay, .asNeeded:
            self.frequency = Day.allCases // 모든 요일을 포함시킵니다.
        case .specificDay:
            self.frequency = frequency // 초기화할 때 받은 특정 요일만 포함시킵니다
        }
        self.alarms = alarms
        self.freOption = freOption
        self.sortedDays = sortedDays 
    }
    
}

#if DEBUG
extension Medicine {
    static var sampleData : [Medicine] = [
        Medicine(name: "콘서타", capacity: "18", unit: "정", frequency: [.monday, .thursday], alarms: [AlarmItem(date: Date.now, isEnabled: false)], freOption: .specificDay, sortedDays: "월, 목"),
        Medicine(name: "메디키넷", capacity: "10", unit: "mg", frequency: [.sunday, .saturday], alarms: [AlarmItem(date: Date(timeIntervalSinceNow: 1800), isEnabled: true)], freOption: .everyDay, sortedDays: "토, 일"),
        Medicine(name: "아빌리파이", capacity: "1", unit: "정", frequency: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday], alarms: [AlarmItem(date: Date(timeIntervalSinceNow: 3600), isEnabled: true)], freOption: .asNeeded, sortedDays: "매일"),
        Medicine(name: "우울약", capacity: "2", unit: "정", frequency: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday], alarms: [AlarmItem(date: Date(timeIntervalSinceNow: 4800), isEnabled: true)], freOption: .specificDay, sortedDays: "매일")
    ]
}
#endif

