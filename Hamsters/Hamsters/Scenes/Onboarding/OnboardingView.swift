//
//  OnboardingView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pageNumber = 0
    
    var body: some View {
        ZStack {
            switch pageNumber {
            case 0:
                AgreementView(pageNumber: $pageNumber)
            case 1:
                NicknameSetView(pageNumber: $pageNumber)
            case 2:
                SexSetView(pageNumber: $pageNumber)
            case 3:
                // 투여 약물 등록 페이지
                EmptyView()
            case 4:
                SmokingSetView(pageNumber: $pageNumber)
            case 5:
                SetupCompleteView(pageNumber: $pageNumber)
            default:
                EmptyView()
                    .onAppear {
//                        if setComplete {
//                            dismiss()
//                        }
                    }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
