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
    
    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    
    @State private var onboardingPage: Onboarding = .welcome
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if 0 < onboardingPage.rawValue && onboardingPage.rawValue < 6 {
                    ProgressBarAndTitle(pageNumber: onboardingPage.rawValue, totalPage: onboardingPage.pageTotal, title: onboardingPage.title, subtitle: onboardingPage.subtitle)
                }
                
                switch onboardingPage {
                case .welcome:
                    WelcomeView(onboardingPage: $onboardingPage)
                case .profile:
                    ProfileSetView(onboardingPage: $onboardingPage)
                case .sex:
                    SexSetView(onboardingPage: $onboardingPage)
                case .medication:
                    TempMediView(onboardingPage: $onboardingPage)
                        .environmentObject(medicineViewModel)
                case .smoking:
                    SmokingSetView(onboardingPage: $onboardingPage)
                case .complete:
                    SetupCompleteView(onboardingPage: $onboardingPage)
                case .end:
                    EmptyView()
                        .onAppear {
                            if setupComplete {
                                dismiss()
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if onboardingPage != .welcome {
                        OnboardingBackButton(onboardingPage: $onboardingPage)
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
