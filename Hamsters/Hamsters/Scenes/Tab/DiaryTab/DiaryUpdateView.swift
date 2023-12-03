//
//  SwiftUIView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/20/23.
//

import SwiftUI

struct DiaryUpdateView: View {
    
    @ObservedObject var viewModel: DiaryMainViewModel

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.currentPage.title)
                    .font(.callout)
                    .fontWeight(.bold)
                Spacer()
                Button{
                    viewModel.isPresentedBottomSheet = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(Color.secondary)

                }
            }
            .padding(.top, 14)
            .padding(.bottom, 12)
            .padding(.horizontal, 16)
            switch viewModel.currentPage {
            case .condition: // ADHD 컨디션 기록
                ConditionCheckView(viewModel: viewModel)
                
            case .mood: // 감정 기록
                MoodCheckView(viewModel: viewModel)
                
            case .sleeping: // 수면 기록
                SleepingTimeView(viewModel: viewModel)
                
            case .sideEffect: // 부작용 기록
                SideEffectCheckView(viewModel: viewModel)
                
            case .weightCheck: // 체중 기록
                WeightCheckView(viewModel: viewModel)
                    .presentationDetents([.medium])
            case .menstruation: // 월경 여부
                MenstruationCheckView(viewModel: viewModel)
                    .presentationDetents([.medium])
            case .activity:
                ActivityView(viewModel: viewModel)
            case .smoking: //  흡연량
                SmokingCheckView(viewModel: viewModel)
                    .presentationDetents([.height(UIScreen.main.bounds.height*0.7)])
            case .caffein: // 카페인
                CaffeineCheckView(viewModel: viewModel)
                    .presentationDetents([.medium])
            case .drink: // 음주량
                DrinkCheckView(viewModel: viewModel)
                    .presentationDetents([.height(UIScreen.main.bounds.height*0.7)])
            case .memo: // 추가 메모
                AdditionalMemoView(viewModel: viewModel)
                    .presentationDetents([.height(UIScreen.main.bounds.height*0.7)])
            case .complete: // 완료 페이지
                DailyCompleteView(viewModel: viewModel)
                
            default:
                EmptyView()
            }
        }

    }
}

#Preview {
    DiaryUpdateView(viewModel: DiaryMainViewModel())
}
