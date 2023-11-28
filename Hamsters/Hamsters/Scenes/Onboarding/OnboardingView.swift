//
//  OnboardingView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var medicineViewModel = MedicineViewModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if 0 < onboardingViewModel.onboardingPage.pageNumber && onboardingViewModel.onboardingPage.pageNumber < 6 {
                    ProgressBarAndTitle(pageNumber: onboardingViewModel.onboardingPage.pageNumber, totalPage: onboardingViewModel.onboardingPage.pageTotal, title: onboardingViewModel.onboardingPage.title, subtitle: onboardingViewModel.onboardingPage.subtitle)
                }
                
                switch onboardingViewModel.onboardingPage {
                case .welcome:
                    WelcomeView()
                    
                case .profile:
                    ProfileSetView()

                case .sex:
                    SexSetView()

                case .medication:
                    MedicationView()
                        .environmentObject(medicineViewModel)
                    
                case .smoking:
                    SmokingSetView()

                case .complete:
                    SetupCompleteView()
                case .end:
                    EmptyView()
                        .onAppear {
                            onboardingViewModel.completeOnboarding()
                            dismiss()
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if onboardingViewModel.onboardingPage != .welcome {
                        OnboardingBackButton(onboardingPage: $onboardingViewModel.onboardingPage)
                    }
                }
            }
        }
        .environmentObject(onboardingViewModel)
    }
}

#Preview {
    OnboardingView()
}
