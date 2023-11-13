//
//  SelectSexView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct SexSetView: View {
    @Binding var onboardingPage: Onboarding
    @Binding var selectedSex: SexClassification?
    
    @State private var isActiveNext = false
    @State private var isMemopause = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack(spacing: 13) {
                Button {
                    selectedSex = .female
                    isActiveNext = true
                } label: {
                    Text("여성")
                        .font(.headline)
                        .foregroundStyle(selectedSex == .female || selectedSex == .menopause ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(selectedSex == .female || selectedSex == .menopause ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
                
                Button {
                    selectedSex = .male
                    isMemopause = false
                    isActiveNext = true
                } label: {
                    Text("남성")
                        .font(.headline)
                        .foregroundStyle(selectedSex == .male ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(selectedSex == .male ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 24)
            
            // 폐경 여부
            if selectedSex == .female || selectedSex == .menopause {
                Button {
                    isMemopause.toggle()
                    if isMemopause {
                        selectedSex = .menopause
                    } else {
                        selectedSex = .female
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
            
            OnboardingNextButton(isActive: $isActiveNext, title: onboardingPage.nextButtonTitle) {
                onboardingPage = Onboarding(rawValue: onboardingPage.rawValue + 1) ?? .medication
            }
        }
        .padding(.top, onboardingPage.topPadding)
        .onAppear {
            if selectedSex != nil {
                isActiveNext = true
            }
        }
    }
}

#Preview {
    SexSetView(onboardingPage: .constant(.sex), selectedSex: .constant(nil))
}
