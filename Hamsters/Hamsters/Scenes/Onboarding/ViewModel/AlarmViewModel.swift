//
//  AlarmViewModel.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//
import Foundation

// 'AlarmViewModel'은 알람 데이터를 관리합니다.
class AlarmViewModel: ObservableObject {
    @Published var alarms: [AlarmItem] = [] // 알람 리스트
    
    // 기본 생성자
    init() {
        self.alarms = []
    }
    
    // 특정 알람들로 초기화하는 생성자
    init(alarms: [AlarmItem]) {
        self.alarms = alarms
    }
    
    // 새 알람을 생성하고 리스트에 추가하는 메서드
    func addAlarmTime(date: Date) {
        let newAlarm = AlarmItem(date: date) // 새 알람 생성
        alarms.append(newAlarm) // 리스트에 새 알람 추가
    }
    
    func removeAlarmTime(at index: Int) {
        alarms.remove(at: index)
    }
    
    func setAlarms(_ alarms: [AlarmItem]) {
        self.alarms = alarms
    }
}
