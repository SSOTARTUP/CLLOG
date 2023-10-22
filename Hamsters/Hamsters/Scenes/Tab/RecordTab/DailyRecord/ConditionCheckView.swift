//
//  CoditionCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI

// 꼭 enum으로 처리해야 할 항목인가..?
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
    @Binding var pageNumber: Int
    @Binding var userValues: [Double]
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(zip(0..<Condition.allCases.count, Condition.allCases)), id: \.0) { index, title in
                        ConditionSlider(title: title.rawValue, userValue: $userValues[index])
                    }
                    DailyRecordNextButton(pageNumber: $pageNumber, title: "다음")
                        .padding(.bottom, 30)
                        .padding(.top, 12)
                }
                .padding(.top, 78)  // title 영역만큼
            }
            .scrollIndicators(.never)
            
            HStack {
                Text("오늘의 컨디션은?")
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
    ConditionCheckView(pageNumber: .constant(1), userValues: .constant([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))
}
