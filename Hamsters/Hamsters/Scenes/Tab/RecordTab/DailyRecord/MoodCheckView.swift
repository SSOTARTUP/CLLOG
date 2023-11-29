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
                if let _ = viewModel as? DailyRecordViewModel {
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
                    }
                }
                VStack(spacing: 16) {
                    ForEach(Array(zip(0..<Mood.allCases.count, Mood.allCases)), id: \.0) { index, mood in
                        
                        ConditionSlider(title: mood.question, userValue: $viewModel.moodValues[index])
                            .padding(.horizontal, 16)

                    }
                    NextButton(title: "다음", isActive: .constant(true)) {
                        viewModel.bottomButtonClicked()
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                }
            }
            .scrollIndicators(.never)
        }
    }
}

#Preview {
    MoodCheckView(viewModel: DailyRecordViewModel())
}
