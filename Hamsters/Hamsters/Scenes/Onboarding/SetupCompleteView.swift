//
//  SetupCompleteView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

struct SetupCompleteView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    let hamsterSize = UIScreen.main.bounds.width - 140
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {                
                VStack {
                    LottieConfettiView(filename: "onboardingHamster")
                        .frame(width: hamsterSize, height: hamsterSize)
//                        .border(.red)

                        
                    Text("준비 완료!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                    
                    Text("일상을 변화시킬 나를 위한 단서,\n클록이 도와줄게요!")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                
                LottieConfettiView(filename: "onboardingConfetti")
            }
            
            Spacer()

            OnboardingNextButton(isActive: .constant(true), title: viewModel.onboardingPage.nextButtonTitle) {
                viewModel.completeOnboarding()
                viewModel.onboardingPage = .end
            }
        }
    }
}

#Preview {
    SetupCompleteView()
}
