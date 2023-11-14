//
//  NextButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

struct OnboardingNextButton: View {
    @Binding var isActive: Bool
    let title: String
    var closure: () -> Void
    
    var body: some View {
        Button {
            closure()
        } label: {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(isActive ? .white : .thoNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(isActive ? .thoNavy : .thoDisabled)
                .cornerRadius(15)
        }
        .disabled(!isActive)
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
    }
}

#Preview {
    OnboardingNextButton(isActive: .constant(true), title: "시작하기") {}
}
