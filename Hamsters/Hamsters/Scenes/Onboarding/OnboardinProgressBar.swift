//
//  OnboardinProgressBar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct OnboardinProgressBar: View {
    @Binding var pageNumber: Int
    var body: some View {
        ProgressView(value: Double(pageNumber), total: 5)
            .tint(.thoNavy)
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
    }
}

#Preview {
    OnboardinProgressBar(pageNumber: .constant(5))
}
