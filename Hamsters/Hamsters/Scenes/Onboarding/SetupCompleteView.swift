//
//  SetupCompleteView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

struct SetupCompleteView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {                
                VStack {
                    Image("HamsterV")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 124)
                        .padding(.bottom, 32)
                        
                    Text("준비 완료!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 12)
                    
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
