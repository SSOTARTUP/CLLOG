//
//  SmokingSatusView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

struct SmokingSetView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    @State private var isActiveNext = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 13) {
                Button {
                    viewModel.smokingStatus = .smoking
                    isActiveNext = true
                } label: {
                    Text("흡연")
                        .font(.headline)
                        .foregroundStyle(viewModel.smokingStatus == .smoking ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.smokingStatus == .smoking ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
                
                Button {
                    viewModel.smokingStatus = .nonSmoking
                    isActiveNext = true
                } label: {
                    Text("비흡연")
                        .font(.headline)
                        .foregroundStyle(viewModel.smokingStatus == .nonSmoking ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.smokingStatus == .nonSmoking ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            OnboardingNextButton(isActive: $isActiveNext, title: viewModel.onboardingPage.nextButtonTitle) {
                viewModel.onboardingPage = .complete
            }
        }
        .padding(.top, viewModel.onboardingPage.topPadding)
        .onAppear {
            if viewModel.smokingStatus != nil {
                isActiveNext = true
            }
        }
    }
}

#Preview {
    SmokingSetView()
}
