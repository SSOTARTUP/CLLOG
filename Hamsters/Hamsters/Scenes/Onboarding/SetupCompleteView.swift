//
//  SetupCompleteView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

struct SetupCompleteView: View {
    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    
    @Binding var onboardingPage: Onboarding
    
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
                    
                    Text("일상을 변화시킬 나를 위한 단서,\nClue가 도와줄게요!")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                
                LottieConfettiView(filename: "onboardingConfetti")
            }
            
            Spacer()

            OnboardingNextButton(isActive: .constant(true), title: onboardingPage.nextButtonTitle) {
                setupComplete = true
                onboardingPage = Onboarding(rawValue: onboardingPage.rawValue + 1) ?? .end
            }
        }
    }
}

#Preview {
    SetupCompleteView(onboardingPage: .constant(.complete))
}
