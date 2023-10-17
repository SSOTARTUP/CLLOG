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

    // 새 알람을 생성하고 리스트에 추가하는 메서드
    func addAlarm(date: Date) {
        let newAlarm = AlarmItem(date: date) // 새 알람 생성
        alarms.append(newAlarm) // 리스트에 새 알람 추가
    }
    
    func removeAlarm(at index: Int) {
        alarms.remove(at: index)
    }
}
