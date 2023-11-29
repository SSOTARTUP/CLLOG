//
//  OnboardingViewModel.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/27/23.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    // 온보딩 저장 사항
    @AppStorage(UserDefaultsKey.userName.rawValue) private var storedUserkname: String = ""
    @AppStorage(UserDefaultsKey.hamsterName.rawValue) private var storedHamsterkname: String = ""
    @AppStorage(UserDefaultsKey.hamsterImage.rawValue) private var storedHamsterImage: String = ""
    @AppStorage(UserDefaultsKey.sex.rawValue) private var storedSex: String = ""
    @AppStorage(UserDefaultsKey.smoking.rawValue) private var storedSmoking: Bool = false
    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    
    @AppStorage(UserDefaultsKey.startDate.rawValue) private var startDate: String = Date().summaryWithTimeWithSecond
    
    // 기록 페이지 구성
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
    
    // 질문 항목 편집
    @AppStorage(UserDefaultsKey.PageControl.period.rawValue) private var isOnPeriod: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.caffeine.rawValue) private var isOnCaffeine: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.smoking.rawValue) private var isOnSmoking: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.drink.rawValue) private var isOnDrink: Bool = true
    
    // 페이지 컨트롤 변수
    @Published var onboardingPage: Onboarding = .welcome
    
    // 임시 저장 변수
    @Published var userName: String = ""
    @Published var hamsterName: String = ""
    @Published var selectedHamster: selectedHam? = nil
    @Published var selectedSex: SexClassification? = nil
    @Published var smokingStatus: SmokingStatus? = nil
    
    private var recordingPages: [DailyRecordPage] = [
        DailyRecordPage.condition,
        DailyRecordPage.mood,
        DailyRecordPage.sleeping,
        DailyRecordPage.sideEffect,
        DailyRecordPage.weightCheck,
    ]
    
    func saveProfileSet() {
        storedUserkname = userName
        storedHamsterkname = hamsterName
        storedHamsterImage = selectedHamster?.rawValue ?? "gray"
    }
    
    func saveSexSet() {
        storedSex = selectedSex?.rawValue ?? "male"
        
        if selectedSex?.rawValue == "female" {
            isOnPeriod = true
            recordingPages.append(DailyRecordPage.menstruation)
        } else {
            isOnPeriod = false
        }
    }
    
    func saveSmokingSet() {
        storedSmoking = smokingStatus?.rawValue ?? false
        
        if smokingStatus?.rawValue == true {
            isOnSmoking = true
            recordingPages.append(DailyRecordPage.smoking)
        } else {
            isOnSmoking = false
        }
    }
    
    func completeOnboarding() {
        let lastPages = [DailyRecordPage.caffein,
                         DailyRecordPage.drink,
                         DailyRecordPage.memo,
                         DailyRecordPage.complete]
        
        saveProfileSet()
        saveSexSet()
        recordingPages.append(DailyRecordPage.encourage)
        recordingPages.append(DailyRecordPage.activity)
        saveSmokingSet()
        recordingPages.append(contentsOf: lastPages)
        
        dailyRecordPages = recordingPages.convertPageToString
        
        isOnCaffeine = true
        isOnDrink = true
        
        setupComplete = true
        
        startDate = Date().summaryWithTimeWithSecond
    }
}

