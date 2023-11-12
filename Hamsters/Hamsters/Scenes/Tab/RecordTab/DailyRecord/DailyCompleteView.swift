//
//  DailyCompleteView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DailyCompleteView: View {
    @Binding var pageNumber: Int
    @Binding var isActiveRecord: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                VStack(spacing: 0) {
                    Image("HamsterV")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 125)
                        .padding(.bottom, 33)
                    
                    Text("수고하셨습니다!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 12)
                    
                    Text("오늘도 기록에 성공하셨어요!\n앞으로도 꾸준히 이어나가보아요!")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                
                LottieConfettiView(filename: "onboardingConfetti")
            }
            
            Spacer()
            
            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord: $isActiveRecord, title: "완료")
            
        }
    }
}

//#Preview {
//    DailyCompleteView(pageNumber: .constant(11))
//}
