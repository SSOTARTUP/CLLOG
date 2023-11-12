//
//  ProgressBarAndTitle.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/7/23.
//

import SwiftUI

struct ProgressBarAndTitle: View {
    let pageNumber: Int
    let totalPage: Double
    let title: String?
    let subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ProgressView(value: Double(pageNumber), total: totalPage)
                .tint(.thoNavy)
                .padding(.vertical, 16)
            
            if let title = title {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    ProgressBarAndTitle(pageNumber: 3, totalPage: 10, title: "드시는 약물이 있나요?", subtitle: "Clue가 햄깅님을 더 잘 케어할 수 있어요!")
}
