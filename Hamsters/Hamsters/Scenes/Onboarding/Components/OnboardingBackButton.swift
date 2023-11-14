//
//  OnboardingBackButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct OnboardingBackButton: View {
    @Binding var onboardingPage: Onboarding
    
    var body: some View {
        Button {
            onboardingPage = Onboarding(rawValue: onboardingPage.rawValue - 1) ?? .welcome
        } label: {
            Image(systemName: "chevron.backward")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.thoNavy)
        }
    }
}

#Preview {
    OnboardingBackButton(onboardingPage: .constant(.smoking))
}
