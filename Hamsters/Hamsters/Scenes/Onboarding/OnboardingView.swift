//
//  OnboardingView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(UserDefaultsKey.nickname.rawValue) private var storedNickname: String = ""
    @AppStorage(UserDefaultsKey.sex.rawValue) private var storedSex: String = ""
    @AppStorage(UserDefaultsKey.smoking.rawValue) private var storedSmoking: Bool = false
    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    @State private var pageNumber = 0
    @State private var nickname = ""
    @State private var selectedSex: SexClassification?
    @State private var status: SmokingStatus?
    
    
    var body: some View {
        ZStack {
            switch pageNumber {
            case 0:
                AgreementView(pageNumber: $pageNumber)
            case 1:
                NicknameSetView(pageNumber: $pageNumber, nickname: $nickname)
                    .onDisappear {
                        storedNickname = nickname
                    }
            case 2:
                SexSetView(pageNumber: $pageNumber, selectedSex: $selectedSex)
                    .onDisappear {
                        storedSex = selectedSex?.rawValue ?? ""
                    }
            case 3:
                // 투여 약물 등록 페이지(임시)
                TempMedicationVeiw(pageNumber: $pageNumber)
            case 4:
                SmokingSetView(pageNumber: $pageNumber, status: $status)
                    .onDisappear {
                        print(status?.rawValue.description ?? "non")
                        storedSmoking = status?.rawValue ?? false
                    }
            case 5:
                SetupCompleteView(pageNumber: $pageNumber)
            default:
                EmptyView()
                    .onAppear {
                        setupComplete = true
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
