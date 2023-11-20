//
//  DailyRecordView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI

struct DailyRecordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var dailyViewModel = DailyViewModel()
    @Binding var isActiveRecord: Bool   // fullScreenCover 제어 위한 변수
    @State private var pageNumber = 1   // 페이지 이동을 위한 변수
    
//    @State private var conditionValues: [Double] = Array(repeating: 0.0, count: Condition.allCases.count)
//    @State private var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
//    @State private var sleepingTime: Int = 0
//    @State private var popularEffect: [SideEffects.Major] = [.none]
//    @State private var dangerEffect: [SideEffects.Dangerous] = [.none]
//    @State private var weight: Double = 50.0
//    @State private var amountOfSmoking = 0
//    @State private var amountOfCaffein = 0
//    @State private var isPeriod = false
//    @State private var amountOfAlcohol = 0
//    @State private var memo = ""
    @State private var closeAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12){
                DailyRecordProgressBar(pageNumber: $pageNumber)

                switch pageNumber {
                case 1: // ADHD 컨디션 기록
                    ConditionCheckView(pageNumber: $pageNumber, userValues: $dailyViewModel.conditionValues)
                    
                case 2: // 감정 기록
                    MoodCheckView(pageNumber: $pageNumber, userValues: $dailyViewModel.moodValues)
                    
                case 3: // 수면 기록
                    SleepingTimeView(pageNumber: $pageNumber, sleepingTime: $dailyViewModel.sleepingTime)
                    
                case 4: // 부작용 기록
                    SideEffectCheckView(pageNumber: $pageNumber, popularEffect: $dailyViewModel.popularEffect, dangerEffect: $dailyViewModel.dangerEffect)
                    
                case 5: // 체중 기록
                    WeightCheckView(pageNumber: $pageNumber, weight: $dailyViewModel.weight)
                    
                case 6: // 월경 여부
                    MenstruationCheckView(pageNumber: $pageNumber, isPeriod: $dailyViewModel.isPeriod)
                    
                case 7: //  흡연량
                    SmokingCheckView(pageNumber: $pageNumber, amountOfSmoking: $dailyViewModel.amountOfSmoking)
                    
                case 8: // 카페인
                    CaffeineCheckView(pageNumber: $pageNumber, amountOfCaffein: $dailyViewModel.amountOfCaffein)
                    
                case 9: // 음주량
                    DrinkCheckView(pageNumber: $pageNumber, amountOfAlcohol: $dailyViewModel.amountOfAlcohol)
                    
                case 10: // 추가 메모
                    AdditionalMemoView(pageNumber: $pageNumber, memo: $dailyViewModel.memo)
                    
                case 11: // 완료 페이지
                        DailyCompleteView(pageNumber: $pageNumber, isActiveRecord: $isActiveRecord, dailyViewModel: dailyViewModel)
                    
                default:
                    EmptyView()
                }
            }
            .navigationTitle("오늘의 상태 기록하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if pageNumber > 1 {
                        backButton
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    if pageNumber < 11 {
                        closeButton
                    }
                }
            }
        }
        .alert("기록 중단", isPresented: $closeAlert) {
            Button("취소", role: .cancel) {
                
            }
            Button("그만하기", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("지금 종료하면 작성한 기록이\n저장되지 않습니다")
        }
    }
    
    private var backButton: some View {
        Button {
            pageNumber -= 1
        } label: {
            Image(systemName: "chevron.backward")
                .fontWeight(.semibold)
                .foregroundStyle(.thoNavy)
        }
    }
    
    private var closeButton: some View {
        Button {
            closeAlert = true
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.thoNavy)
        }
    }
}

#Preview {
    DailyRecordView(isActiveRecord: .constant(true))
}
