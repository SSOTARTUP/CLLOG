//
//  CoditionCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI

enum Condition: String, CaseIterable {
    case inattentive = "산만한 정도"
    case attention = "집중하기 어려움"
    case finish = "끝맺기 어려움"
    case arrange = "정리하기 어려움"
    case impulsivity = "충동성"
    case hyperactivity = "과잉행동"
    case restlessness = "안절부절함"
}

struct ConditionCheckView: View {
    @ObservedObject var viewModel: DiaryMainViewModel

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Array(ConditionModel.ConditionType.allCases.enumerated()), id: \.0) { index, title in
                        ConditionSlider(title: title.name, userValue: $viewModel.userValues[index])
                    }

                    NextButton(title: "확인", isActive: .constant(true)) {
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
    ConditionCheckView(viewModel: DiaryMainViewModel())
}
