//
//  SelectSexView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct SexSetView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    @State private var isActiveNext = false
    @State private var isMemopause = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack(spacing: 13) {
                Button {
                    viewModel.selectedSex = .female
                    isActiveNext = true
                } label: {
                    Text("여성")
                        .font(.headline)
                        .foregroundStyle(viewModel.selectedSex == .female || viewModel.selectedSex == .menopause ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.selectedSex == .female || viewModel.selectedSex == .menopause ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
                
                Button {
                    viewModel.selectedSex = .male
                    isMemopause = false
                    isActiveNext = true
                } label: {
                    Text("남성")
                        .font(.headline)
                        .foregroundStyle(viewModel.selectedSex == .male ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.selectedSex == .male ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 24)
            
            // 폐경 여부
            if viewModel.selectedSex == .female || viewModel.selectedSex == .menopause {
                Button {
                    isMemopause.toggle()
                    if isMemopause {
                        viewModel.selectedSex = .menopause
                    } else {
                        viewModel.selectedSex = .female
                    }
                } label: {
                    HStack {
                        Image(systemName: isMemopause ? "checkmark.circle.fill" : "circle")
                            .font(.title)
                            .foregroundStyle(isMemopause ? .thoNavy : Color.secondary)
                        
                        Text("저는 월경을 하지 않아요!")
                            .font(.body)
                            .foregroundStyle(Color.primary)
                    }
                    .padding(.leading, 33)
                }
            }
            
            Spacer()
            
            OnboardingNextButton(isActive: $isActiveNext, title: viewModel.onboardingPage.nextButtonTitle) {
                viewModel.onboardingPage = .medication
            }
        }
        .padding(.top, viewModel.onboardingPage.topPadding)
        .onAppear {
            if viewModel.selectedSex != nil {
                isActiveNext = true
            }
        }
    }
}

#Preview {
    SexSetView()
}
