//
//  DailyRecordView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI

struct DailyRecordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pageNumber = 1
    @State private var conditionValues: [Double] = Array(repeating: 0.0, count: Condition.allCases.count)
    @State private var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
    @State private var amountOfSmoking = 0
    @State private var amountOfCaffein = 0
    @State private var selectedCaffeine: [Bool] = Array(repeating: false, count: 10)
    @State private var amountOfAlcohol = 0
    @State private var memo = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12){
                DailyRecordProgressBar(pageNumber: $pageNumber)
                
                ZStack {
                    switch pageNumber {
                    case 1: // ADHD 컨디션 기록
                        ConditionCheckView(pageNumber: $pageNumber, userValues: $conditionValues)
                        
                    case 2: // 감정 기록
                        MoodCheckView(pageNumber: $pageNumber, userValues: $moodValues)
                        
                    case 3: // 수면 기록
                        SleepingTimeView(pageNumber: $pageNumber)
                        
                    case 4: // 부작용 기록
                        SideEffectCheckView(pageNumber: $pageNumber)
                        
                    case 5: // 체중 기록
                        WeightCheckView(pageNumber: $pageNumber)
                        
                    case 6: // 월경 여부
                        MenstruationCheckView(pageNumber: $pageNumber)
                        
                    case 7: //  흡연량
                        SmokingCheckView(pageNumber: $pageNumber, amountOfSmoking: $amountOfSmoking)
                        
                    case 8: // 카페인
                        CaffeineCheckView(pageNumber: $pageNumber, amountOfCaffein: $amountOfCaffein, isSelected: $selectedCaffeine)
                        
                    case 9: // 음주량
                        DrinkCheckView(pageNumber: $pageNumber, amountOfAlcohol: $amountOfAlcohol)
                        
                    case 10: // 추가 메모
                            AdditionalMemoView(pageNumber: $pageNumber, memo: $memo)
                        
                    case 11: // 완료 페이지
                        DailyCompleteView(pageNumber: $pageNumber)
                        
                    default:
                        EmptyView()
                    }
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
                    closeButton
                }
            }
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
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.thoNavy)
        }
    }
}

#Preview {
    DailyRecordView()
}
