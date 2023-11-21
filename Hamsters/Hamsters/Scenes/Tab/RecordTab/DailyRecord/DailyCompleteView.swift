//
//  DailyCompleteView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DailyCompleteView<T: RecordProtocol>: View {

    @ObservedObject var viewModel: T
    @Environment(\.dismiss) private var dismiss


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
                    
                    Text("오늘도 기록 완료!")
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
            

            NextButton(title: "다음", isActive: .constant(true)) {
                if let vm = viewModel as? DailyRecordViewModel {
                    dismiss()
                    vm.saveRecord()
                }
                
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    DailyCompleteView(viewModel: DailyRecordViewModel())
}
