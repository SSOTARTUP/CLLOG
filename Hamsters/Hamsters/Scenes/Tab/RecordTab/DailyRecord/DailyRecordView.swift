//
//  DailyRecordView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//  Edited by jaesik Pyeon on 16/11/23

import SwiftUI

struct DailyRecordView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isActiveSheet:Bool
    
    @StateObject var viewModel = DailyRecordViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 12){
                DailyRecordProgressBar(pageNumber: viewModel.pageNumber, total: viewModel.dailyRecordPages.convertStringToPage.count)


                switch viewModel.currentPage {
                case .condition: // ADHD 컨디션 기록
                    ConditionView(dailyRecordViewModel: viewModel)
                case .mood: // 감정 기록
                    MoodCheckView(viewModel: viewModel)
                    
                case .sleeping: // 수면 기록
                    SleepingTimeView(viewModel: viewModel)
                    
                case .sideEffect: // 부작용 기록
                    SideEffectCheckView(dailyRecordViewModel: viewModel)
                    
                case .weightCheck: // 체중 기록
                    WeightCheckView(dailyRecordViewModel: viewModel)
                    
                case .menstruation: // 월경 여부
                    MenstruationCheckView(dailyRecordViewModel: viewModel)
                    
                case .smoking: //  흡연량
                    SmokingCheckView(dailyRecordViewModel: viewModel)
                    
                case .caffein: // 카페인
                    CaffeineCheckView(dailyRecordViewModel: viewModel)
                    
                case .drink: // 음주량
                    DrinkCheckView(dailyRecordViewModel: viewModel)
                    
                case .memo: // 추가 메모
                    AdditionalMemoView(dailyRecordViewModel: viewModel)

                case .complete: // 완료 페이지
                    DailyCompleteView(dailyRecordViewModel: viewModel)
                }
            }
            .navigationTitle("오늘의 상태 기록하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if viewModel.currentPage != .condition {
                        backButton
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    if viewModel.currentPage != .complete {
                        closeButton
                    }
                }
            }
        }
        .alert("기록 중단", isPresented: $viewModel.closeAlert) {
            Button("취소", role: .cancel) {
                
            }
            Button("그만하기", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("지금 종료하면 작성한 기록이\n저장되지 않습니다")
        }
    }
}

//MARK: back&close button
extension DailyRecordView {
    private var backButton: some View {
        Button {
            viewModel.goToPreviousPage()
        } label: {
            Image(systemName: "chevron.backward")
                .fontWeight(.semibold)
                .foregroundStyle(.thoNavy)
        }
    }
    
    private var closeButton: some View {
        Button {
            viewModel.closeAlert = true
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.thoNavy)
        }
    }
}

#Preview {
    DailyRecordView(isActiveSheet: .constant(true))
}
