//
//  DailyRecordView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//  Edited by jaesik Pyeon on 16/11/23

import SwiftUI

enum DailyRecordPage: Int, CaseIterable {
    case condition
    case mood
    case sleeping
    case sideEffect
    case weightCheck
    case menstruation
    case smoking
    case caffein
    case drink
    case memo
    case complete
}


typealias DailyRecordPages = [DailyRecordPage]
extension DailyRecordPages {
    var convertPageToString: String {
        self.sorted{ $0.rawValue < $1.rawValue }
            .map { String($0.rawValue) }.joined()
    }
}

extension String {
    var convertStringToPage: [DailyRecordPage] {
        self.compactMap { Int(String($0)) }
            .sorted{ $0 < $1 }
            .compactMap { DailyRecordPage(rawValue: $0) }
    }
}

struct DailyRecordView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isActiveRecord: Bool   // fullScreenCover 제어 위한 변수
    @State private var pageNumber = 1   // 페이지 이동을 위한 변수
    
    @State private var conditionValues: [Double] = Array(repeating: 0.0, count: Condition.allCases.count)
    @State private var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
    @State private var sleepingTime: Int = 0
    @State private var popularEffect: [SideEffects.Major] = [.none]
    @State private var dangerEffect: [SideEffects.Dangerous] = [.none]
    @State private var weight: Double = 50.0
    @State private var amountOfSmoking = 0
    @State private var amountOfCaffein = 0
    @State private var isPeriod = false
    @State private var amountOfAlcohol = 0
    @State private var memo = ""
    @State private var closeAlert = false
    
//    @AppStorage("dailyRecordPage") private var dailyRecordPages: String = [
//        DailyRecordPage.condition,
//        DailyRecordPage.mood,
//        DailyRecordPage.sleeping
//    ].convertPageToString

    @State private var currentPage: DailyRecordPage = .condition

    @StateObject var viewModel = DailyRecordViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12){
                DailyRecordProgressBar(pageNumber: $pageNumber)

                switch viewModel.currentPage {
                case .condition: // ADHD 컨디션 기록
                    ConditionView(dailyRecordViewModel: viewModel)
                case .mood: // 감정 기록
                    MoodCheckView(dailyRecordViewModel: viewModel)
                    
                case .sleeping: // 수면 기록
                    SleepingTimeView(dailyRecordViewModel: viewModel)
                    
                case .sideEffect: // 부작용 기록
                    SideEffectCheckView(dailyRecordViewModel: viewModel)
                    
                case .weightCheck: // 체중 기록
                    WeightCheckView(dailyRecordViewModel: viewModel)
//                    WeightCheckView(pageNumber: $pageNumber, weight: $weight)
                    
                case .menstruation: // 월경 여부
                    MenstruationCheckView(pageNumber: $pageNumber, isPeriod: $isPeriod)
                    
                case .smoking: //  흡연량
                    SmokingCheckView(pageNumber: $pageNumber, amountOfSmoking: $amountOfSmoking)
                    
                case .caffein: // 카페인
                    CaffeineCheckView(pageNumber: $pageNumber, amountOfCaffein: $amountOfCaffein)
                    
                case .drink: // 음주량
                    DrinkCheckView(pageNumber: $pageNumber, amountOfAlcohol: $amountOfAlcohol)
                    
                case .memo: // 추가 메모
                        AdditionalMemoView(pageNumber: $pageNumber, memo: $memo)
                    
                case .complete: // 완료 페이지
                    DailyCompleteView(pageNumber: $pageNumber, isActiveRecord: $isActiveRecord)
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
