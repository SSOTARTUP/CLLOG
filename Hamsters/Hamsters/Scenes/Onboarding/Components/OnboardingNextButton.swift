//
//  NextButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

struct OnboardingNextButton: View {
    @Binding var isActive: Bool
    @Binding var pageNumber: Int
    
    var body: some View {
        Button {
            pageNumber += 1
        } label: {
            Text("다음")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(isActive ? .white : .thoNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(isActive ? .thoNavy : .thoDisabled)
                .cornerRadius(15)
        }
        .disabled(!isActive)
    }
}

#Preview {
    OnboardingNextButton(isActive: .constant(true), pageNumber: .constant(1))
}
