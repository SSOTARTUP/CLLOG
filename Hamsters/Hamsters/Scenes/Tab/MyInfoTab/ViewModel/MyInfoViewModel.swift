//
//  MyInfoViewModel.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/20/23.
//

import SwiftUI

class MyInfoViewModel: ObservableObject {
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
    
    @AppStorage(UserDefaultsKey.sex.rawValue) var savedSex: String?
    
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
        ]
        
        if onPeriod {
            basicPages.append(DailyRecordPage.menstruation)
        }
        
        var midPages: [DailyRecordPage] = [
            DailyRecordPage.encourage,
            DailyRecordPage.activity
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
        
        dailyRecordPages = (basicPages + midPages + endingPages).convertPageToString
    }
}
