//
//  MoodCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/20/23.
//

import SwiftUI

enum Mood: String, CaseIterable {
    case depression = "우울한"
    case upswell = "고조된"
    case anger = "화난"
    case anxiety = "불안한"
}

struct MoodCheckView: View {
    @Binding var pageNumber: Int
    @Binding var userValues: [Double]
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(zip(0..<Mood.allCases.count, Mood.allCases)), id: \.0) { index, mood in
                        let title = "오늘의 가장 " + mood.rawValue + " 정도"
                        ConditionSlider(title: title, userValue: $userValues[index])
                    }
                    
                    DailyRecordNextButton(pageNumber: $pageNumber, title: "다음")
                        .padding(.bottom, 30)
                        .padding(.top, 12)
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
    MoodCheckView(pageNumber: .constant(2), userValues: .constant([0.0, 0.0, 0.0, 0.0]))
}
