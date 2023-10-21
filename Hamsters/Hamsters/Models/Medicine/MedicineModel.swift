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
    var fullCapacity: String { "\(capacity)\(unit)" }  // 용량과 단위를 결합한 문자열 표현
    var frequency: [Day]  // 약을 복용할 요일
    var startTime: Date  // 복용 시작 일자
    var alarms: [AlarmItem]  // 설정된 알람들
    var sortedDays: String
    
    // Medicine 인스턴스를 생성할 때 필요한 모든 정보를 채워 넣을 수 있도록 생성
    
    init(id: UUID = UUID(), name: String, capacity: String, unit: String, frequency: [Day], startTime: Date, alarms: [AlarmItem], sortedDays: String) {
        self.id = id
        self.name = name
        self.capacity = capacity
        self.unit = unit
        self.frequency = frequency
        self.startTime = startTime
        self.alarms = alarms
        self.sortedDays = sortedDays
    }
    
}
