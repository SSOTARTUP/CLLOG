//
//  DailyRecordViewModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/16/23.
//

import Foundation
import SwiftUI

class DailyRecordViewModel: RecordProtocol {
    
    private let coreDataManager = CoreDataManager.shared
    
    @AppStorage(UserDefaultsKey.dailyRecordPage.rawValue) var dailyRecordPages: String = [
        DailyRecordPage.condition,
        DailyRecordPage.mood,
        DailyRecordPage.sleeping,
        DailyRecordPage.sideEffect,
        DailyRecordPage.weightCheck,
        DailyRecordPage.menstruation,
        DailyRecordPage.encourage,
        DailyRecordPage.activity,
        DailyRecordPage.smoking,
        DailyRecordPage.caffein,
        DailyRecordPage.drink,
        DailyRecordPage.memo,
        DailyRecordPage.complete
    ].convertPageToString
    
    
    @Published var closeAlert: Bool = false
    
    @Published var currentPage: DailyRecordPage = .condition
    
    @Published var answer: ConditionViewModel.ConditionAnswer = [:]
    
    @Published var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
    
    @Published var sleepingTime: Int = 0
    @Published var startAngle: Double = 0
    @Published var toAngle: Double = 180
    @Published var startProgress: CGFloat = 0
    @Published var toProgress: CGFloat = 0.5
    
    @Published var popularEffect: [SideEffects.Major] = [.none]
    
    @Published var dangerEffect: [SideEffects.Dangerous] = [.none]
    
    @Published var weight: Double = 50.0
    @Published var selectedKg: Int = 50
    @Published var selectedGr: Int = 0
    
    @Published var amountOfSmoking = 0
    
    @Published var amountOfCaffein = 0
    
    @Published var isPeriod = false
    
    @Published var list: Activities = []
    
    @Published var isSelected: [Bool] = Array(repeating: false, count: 10)
    @Published var isTaken: CaffeineIntake? = .not
    
    @Published var amountOfAlcohol = 0
    
    @Published var memo = ""
    
    @Published var pageNumber = 0
    
    func bottomButtonClicked() {
        pageNumber += pageNumber < dailyRecordPages.convertStringToPage.count - 1 ? 1 : 0
        currentPage = dailyRecordPages.convertStringToPage[pageNumber]
    }
    
    func goToPreviousPage() {
        pageNumber -= pageNumber > 0 ? 1 :0
        currentPage = dailyRecordPages.convertStringToPage[pageNumber]
    }
    
    func saveRecord() {
        let dayRecord = DayRecord(
            date: startOfDay(for: Date()), // 저장 시 현재 날짜 사용
            conditionValues: answer.map{ $0 }.sorted{ $0.key.rawValue < $1.key.rawValue }.map{ Double($0.value.rawValue) },
            moodValues: moodValues,
            sleepingTime: sleepingTime,
            popularEffect: popularEffect,
            dangerEffect: dangerEffect,
            weight: weight,
            acitivty: list,
            amountOfSmoking: amountOfSmoking,
            amountOfCaffein: amountOfCaffein,
            isPeriod: isPeriod,
            amountOfAlcohol: amountOfAlcohol,
            memo: memo
        )
        
        DayRecordsManager.shared.saveDayRecord(dayRecord)
    }
    
    func loadHealthKitSleepData() {
        HealthKitManager.shared.fetchSleepData(.today) { sleepStart, sleepEnd, _ in
            DispatchQueue.main.async {
                guard let sleepStart = sleepStart, let sleepEnd = sleepEnd else {
                    print("HealthKit에서 수면 데이터를 가져올 수 없습니다.")
                    return
                }
                
                // 수면 시작 및 종료 시간을 기반으로 각도와 진행 상태를 설정합니다.
                self.startAngle = self.calculateAngle(from: sleepStart)
                self.toAngle = self.calculateAngle(from: sleepEnd)
                self.startProgress = self.calculateProgress(from: sleepStart)
                self.toProgress = self.calculateProgress(from: sleepEnd)
            }
        }
    }
    
    // 날짜를 각도로 변환하는 함수
    func calculateAngle(from date: Date) -> Double {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        // 360도 원에서 각 시간당 15도, 각 분당 0.25도
        return Double(hour) * 15.0 + Double(minutes) * 0.25
    }
    
    // 날짜를 진행 상태(0.0 ~ 1.0)로 변환하는 함수
    func calculateProgress(from date: Date) -> CGFloat {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        // 24시간을 기준으로 한 시간과 분의 비율
        let totalMinutes = Double(hour) * 60.0 + Double(minutes)
        return CGFloat(totalMinutes / 1440.0) // 하루는 1440분
    }
    
    func startOfDay(for date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
}
