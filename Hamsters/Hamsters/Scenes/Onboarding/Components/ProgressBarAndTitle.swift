//
//  ProgressBarAndTitle.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/7/23.
//

// 온보딩 통합때 사용 예정

import SwiftUI

struct ProgressBarAndTitle: View {
    @Binding var pageNumber: Int
    let totalPage: Double
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ProgressView(value: Double(pageNumber), total: totalPage)
                .tint(.thoNavy)
                .padding(.vertical, 16)
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    ProgressBarAndTitle(pageNumber: .constant(3), totalPage: 10, title: "성별을 선택해주세요")
}
