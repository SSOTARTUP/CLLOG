//
//  MoodCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/20/23.
//

import SwiftUI

enum Mood: CaseIterable {
    case depression
    case upswell
    case anger
    case anxiety
    
    var question: String {
        switch self {
        case .depression:
            "자주 울적한 기분이 들었나요?"
        case .upswell:
            "평소보다 흥분되거나 들뜬 기분이 들었나요?"
        case .anger:
            "자주 화가 났거나 통제하기 어려웠나요?"
        case .anxiety:
            "무언가에 대해 불필요하게 걱정하거나\n막연한 불안감이 있었나요?"
        }
    }
}

struct MoodCheckView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Array(zip(0..<Mood.allCases.count, Mood.allCases)), id: \.0) { index, mood in
                        
                        ConditionSlider(title: mood.question, userValue: $viewModel.moodValues[index])
                            .padding(.horizontal, 16)

                    }
                    NextButton(title: "다음", isActive: .constant(true)) {
                        if let vm = viewModel as? DailyRecordViewModel {
                            vm.goToNextPage()
                        }
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 40)
//                    DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord:.constant(true), title: "다음")
//                        .padding(.top, 12)
                }
                .padding(.top, 78)  // title 영역만큼
            }
            .scrollIndicators(.never)
            
            HStack {
                Text("오늘의 기분은 어땠나요?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 16)
                
                Spacer()
            }
            .padding(.leading, 16)
            .background {
                Rectangle()
                    .fill(.white)
//                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 4)
//                    .mask(Rectangle().padding(.bottom, -16))
            }
        }
    }
}

#Preview {
    MoodCheckView(viewModel: DailyRecordViewModel())
}
