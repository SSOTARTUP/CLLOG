//
//  SwiftUIView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/20/23.
//

import SwiftUI

struct DiaryUpdateView: View {
    
    let currentPage: DailyRecordPage?
    
    var body: some View {
        switch currentPage {
        case .condition: // ADHD 컨디션 기록
            EmptyView()
        default:
            EmptyView()
    //        ConditionView()
//        case .mood: // 감정 기록
//     //       MoodCheckView()
//            
//        case .sleeping: // 수면 기록
//            SleepingTimeView(dailyRecordViewModel: viewModel)
//            
//        case .sideEffect: // 부작용 기록
//            SideEffectCheckView(dailyRecordViewModel: viewModel)
//            
//        case .weightCheck: // 체중 기록
//            WeightCheckView(dailyRecordViewModel: viewModel)
//            
//        case .menstruation: // 월경 여부
//            MenstruationCheckView(dailyRecordViewModel: viewModel)
//            
//        case .smoking: //  흡연량
//            SmokingCheckView(dailyRecordViewModel: viewModel)
//            
//        case .caffein: // 카페인
//            CaffeineCheckView(dailyRecordViewModel: viewModel)
//            
//        case .drink: // 음주량
//            DrinkCheckView(dailyRecordViewModel: viewModel)
//            
//        case .memo: // 추가 메모
//            AdditionalMemoView(dailyRecordViewModel: viewModel)
//
//        case .complete: // 완료 페이지
//            DailyCompleteView(dailyRecordViewModel: viewModel)
        }
    }
}

#Preview {
    DiaryUpdateView(currentPage: .condition)
}
