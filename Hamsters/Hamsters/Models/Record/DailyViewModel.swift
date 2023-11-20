//
//  DailyViewModel.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/20/23.
//

import Foundation
import CoreData

class DailyViewModel: ObservableObject {
    @Published var conditionValues: [Double] = Array(repeating: 0.0, count: Condition.allCases.count)
    @Published var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
    @Published var sleepingTime: Int = 0
    @Published var popularEffect: [SideEffects.Major] = [.none]
    @Published var dangerEffect: [SideEffects.Dangerous] = [.none]
    @Published var weight: Double = 50.0
    @Published var amountOfSmoking: Int = 0
    @Published var amountOfCaffein: Int = 0
    @Published var isPeriod: Bool = false
    @Published var amountOfAlcohol: Int = 0
    @Published var memo: String = ""
    
    private let coreDataManager = CoreDataManager.shared
    
    private var selectedDate: Date = Date() // 기록 수정 할 때 날짜
    
    // 저장 로직
    func saveRecord() {
        let dayRecord = DayRecord(
            date: startOfDay(for: Date()), // 저장 시 현재 날짜 사용
            conditionValues: conditionValues,
            moodValues: moodValues,
            sleepingTime: sleepingTime,
            popularEffect: popularEffect,
            dangerEffect: dangerEffect,
            weight: weight,
            amountOfSmoking: amountOfSmoking,
            amountOfCaffein: amountOfCaffein,
            isPeriod: isPeriod,
            amountOfAlcohol: amountOfAlcohol,
            memo: memo
        )
        print("CoreData::: DayRecord 저장 성공")
        coreDataManager.addDayRecord(dayRecord)
    }
    
    // 조건값 업데이트
    func updateConditionValues(_ newValues: [Double]) {
        conditionValues = newValues
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "conditionValues", newValue: newValues)
    }
    
    // 기분값 업데이트
    func updateMoodValues(_ newValues: [Double]) {
        moodValues = newValues
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "moodValues", newValue: newValues)
    }
    
    // 수면 시간 업데이트
    func updateSleepingTime(_ newTime: Int) {
        sleepingTime = newTime
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "sleepingTime", newValue: Int16(newTime))
    }
    
    // 주요 부작용 업데이트
    func updatePopularEffect(_ newEffects: [SideEffects.Major]) {
        popularEffect = newEffects
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "popularEffect", newValue: newEffects)
    }
    
    // 위험 부작용 업데이트
    func updateDangerEffect(_ newEffects: [SideEffects.Dangerous]) {
        dangerEffect = newEffects
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "dangerEffect", newValue: newEffects)
    }
    
    // 체중 업데이트
    func updateWeight(_ newWeight: Double) {
        weight = newWeight
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "weight", newValue: newWeight)
    }
    
    // 흡연량 업데이트
    func updateAmountOfSmoking(_ newAmount: Int) {
        amountOfSmoking = newAmount
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "amountOfSmoking", newValue: Int16(newAmount))
    }
    
    // 카페인 섭취량 업데이트
    func updateAmountOfCaffein(_ newAmount: Int) {
        amountOfCaffein = newAmount
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "amountOfCaffein", newValue: Int16(newAmount))
    }
    
    // 월경 여부 업데이트
    func updateIsPeriod(_ newStatus: Bool) {
        isPeriod = newStatus
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "isPeriod", newValue: newStatus)
    }
    
    // 알코올 섭취량 업데이트
    func updateAmountOfAlcohol(_ newAmount: Int) {
        amountOfAlcohol = newAmount
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "amountOfAlcohol", newValue: Int16(newAmount))
    }
    
    // 메모 업데이트
    func updateMemo(_ newMemo: String) {
        memo = newMemo
        coreDataManager.updateSpecificDayRecord(date: selectedDate, fieldKey: "memo", newValue: newMemo)
    }
    
    // 년 월 일만 시간 제거
    func startOfDay(for date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
}
