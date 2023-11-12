//
//  SmokingSatusView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

struct SmokingSetView: View {
    @AppStorage(UserDefaultsKey.smoking.rawValue) private var storedSmoking: Bool = false
    
    @Binding var onboardingPage: Onboarding
    @State private var status: SmokingStatus? = nil
    @State private var isActiveNext = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 13) {
                Button {
                    status = .smoking
                    isActiveNext = true
                } label: {
                    Text("흡연")
                        .font(.headline)
                        .foregroundStyle(status == .smoking ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(status == .smoking ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
                
                Button {
                    status = .nonSmoking
                    isActiveNext = true
                } label: {
                    Text("비흡연")
                        .font(.headline)
                        .foregroundStyle(status == .nonSmoking ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(status == .nonSmoking ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            OnboardingNextButton(isActive: $isActiveNext, title: onboardingPage.nextButtonTitle) {
                storedSmoking = status?.rawValue ?? false
                onboardingPage = Onboarding(rawValue: onboardingPage.rawValue + 1) ?? .complete
            }
        }
        .padding(.top, onboardingPage.topPadding)
        .onAppear {
            if status != nil {
                isActiveNext = true
            }
        }
    }
}

#Preview {
    SmokingSetView(onboardingPage: .constant(.smoking))
}
