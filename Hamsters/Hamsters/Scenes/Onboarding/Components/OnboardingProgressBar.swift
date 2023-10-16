//
//  OnboardinProgressBar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct OnboardingProgressBar: View {
    @Binding var pageNumber: Int
    
    var body: some View {
        ProgressView(value: Double(pageNumber), total: 5)
            .tint(.thoNavy)
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .padding(.bottom, 15)
    }
}

#Preview {
    OnboardingProgressBar(pageNumber: .constant(5))
}
