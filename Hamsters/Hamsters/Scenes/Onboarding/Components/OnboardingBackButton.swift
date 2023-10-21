//
//  OnboardingBackButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct OnboardingBackButton: View {
    @Binding var pageNumber: Int
    var body: some View {
        Button {
            pageNumber -= 1
        } label: {
            Image(systemName: "chevron.backward")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.thoNavy)
        }
    }
}

#Preview {
    OnboardingBackButton(pageNumber: .constant(3))
}
