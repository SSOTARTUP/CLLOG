//
//  MyInfoViewModel.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/20/23.
//

import SwiftUI

// 운동이랑 중간 격려 페이지 추가 필요
// 남성의 경우 기본적으로 isOnPeriod = false 될 수 있도록 설정 필요

class MyInfoViewModel: ObservableObject {
    @AppStorage(UserDefaultsKey.dailyRecordPage.rawValue) var dailyRecordPages: String?
    
    @AppStorage(UserDefaultsKey.PageControl.period.rawValue) private var isOnPeriod: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.caffeine.rawValue) private var isOnCaffeine: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.smoking.rawValue) private var isOnSmoking: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.drink.rawValue) private var isOnDrink: Bool = true
    
    @Published var onPeriod = UserDefaults.standard.bool(forKey: UserDefaultsKey.PageControl.period.rawValue)
    @Published var onCaffeine = UserDefaults.standard.bool(forKey: UserDefaultsKey.PageControl.caffeine.rawValue)
    @Published var onSmoking = UserDefaults.standard.bool(forKey: UserDefaultsKey.PageControl.smoking.rawValue)
    @Published var onDrink = UserDefaults.standard.bool(forKey: UserDefaultsKey.PageControl.drink.rawValue)
    
    func saveSettings() {
        isOnPeriod = onPeriod
        isOnCaffeine = onCaffeine
        isOnSmoking = onSmoking
        isOnDrink = onDrink
    }
    
    func savePages() {
        var basicPages = [
            DailyRecordPage.condition,
            DailyRecordPage.mood,
            DailyRecordPage.sleeping,
            DailyRecordPage.sideEffect,
            DailyRecordPage.weightCheck,
            DailyRecordPage.condition,
        ]
        
        if onPeriod {
            basicPages.append(DailyRecordPage.menstruation)
        }
        
        var midPages: [DailyRecordPage] = [
            // 아직 Enum에 없음..
//            DailyRecordPage.cheerUp,
//            DailyRecordPage.activity
        ]
        
        if onCaffeine {
            midPages.append(DailyRecordPage.caffein)
        }
        
        if onSmoking {
            midPages.append(DailyRecordPage.smoking)
        }
        
        if onDrink {
            midPages.append(DailyRecordPage.drink)
        }
        
        let endingPages = [
            DailyRecordPage.memo,
            DailyRecordPage.complete
        ]
        
        // midPage 추가 필요
        dailyRecordPages = (basicPages + midPages + endingPages).convertPageToString
    }
}
