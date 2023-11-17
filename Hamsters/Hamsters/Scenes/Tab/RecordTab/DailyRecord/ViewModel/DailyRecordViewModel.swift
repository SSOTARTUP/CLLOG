//
//  DailyRecordViewModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/16/23.
//

import Foundation
import SwiftUI

class DailyRecordViewModel: ObservableObject {
    
    @AppStorage(UserDefaultsKey.dailyRecordPage.rawValue) var dailyRecordPages: String = [
        DailyRecordPage.condition,
        DailyRecordPage.mood,
        DailyRecordPage.sleeping,
        DailyRecordPage.sideEffect,
        DailyRecordPage.weightCheck,
        DailyRecordPage.menstruation,
        DailyRecordPage.smoking,
        DailyRecordPage.caffein,
        DailyRecordPage.drink,
        DailyRecordPage.memo,
        DailyRecordPage.complete
    ].convertPageToString
    
    @Published var currentPage: DailyRecordPage = .condition
    
    @Published var conditionValues: [Double] = Array(repeating: 0.0, count: Condition.allCases.count)
    @Published var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
    @Published var sleepingTime: Int = 0
    @Published var popularEffect: [SideEffects.Major] = [.none]
    @Published var dangerEffect: [SideEffects.Dangerous] = [.none]
    @Published var weight: Double = 50.0
    @Published var amountOfSmoking = 0
    @Published var amountOfCaffein = 0
    @Published var isPeriod = false
    @Published var amountOfAlcohol = 0
    @Published var memo = ""
    
    
    @Published var pageNumber = 0
    
    func goToNextPage() {
        pageNumber += pageNumber < dailyRecordPages.convertStringToPage.count - 1 ? 1 : 0
        currentPage = dailyRecordPages.convertStringToPage[pageNumber]
    }
    
    func goToPreviousPage() {
        pageNumber -= pageNumber > 0 ? 1 :0
        currentPage = dailyRecordPages.convertStringToPage[pageNumber]
    }
}
