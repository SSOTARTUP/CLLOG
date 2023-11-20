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
    
    @AppStorage(UserDefaultsKey.userName.rawValue) private var storedUserkname: String = ""
    @AppStorage(UserDefaultsKey.hamsterName.rawValue) private var storedHamsterkname: String = ""
    @AppStorage(UserDefaultsKey.hamsterImage.rawValue) private var storedHamsterImage: String = ""
    @AppStorage(UserDefaultsKey.sex.rawValue) private var storedSex: String = ""
    @AppStorage(UserDefaultsKey.smoking.rawValue) private var storedSmoking: Bool = false
    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    
    @State private var onboardingPage: Onboarding = .welcome
    
    @State private var userName: String = ""
    @State private var hamsterName: String = ""
    @State private var selectedHamster: selectedHam? = nil
    @State private var selectedSex: SexClassification? = nil
    @State private var smokingStatus: SmokingStatus? = nil
    
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
                    ProfileSetView(onboardingPage: $onboardingPage, hamName: $hamsterName, name: $userName, selectedHamster: $selectedHamster)
                        .onDisappear {
                            storedUserkname = userName
                            storedHamsterkname = hamsterName
                            storedHamsterImage = selectedHamster?.rawValue ?? "gray"
                        }
                case .sex:
                    SexSetView(onboardingPage: $onboardingPage, selectedSex: $selectedSex)
                        .onDisappear {
                            storedSex = selectedSex?.rawValue ?? "male"
                        }
                case .medication:
                    MedicationView(onboardingPage: $onboardingPage)
                        .environmentObject(medicineViewModel)
                case .smoking:
                    SmokingSetView(onboardingPage: $onboardingPage, status: $smokingStatus)
                        .onDisappear {
                            storedSmoking = smokingStatus?.rawValue ?? false
                        }
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
