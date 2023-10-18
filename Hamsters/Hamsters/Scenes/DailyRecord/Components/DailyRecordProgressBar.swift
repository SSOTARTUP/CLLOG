//
//  DailyRecordProgressBar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI

struct DailyRecordProgressBar: View {
    @Binding var pageNumber: Int
    
    var body: some View {
        ProgressView(value: Double(pageNumber), total: 12)
            .tint(.thoNavy)
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .padding(.bottom, 15)
    }
}

#Preview {
    DailyRecordProgressBar(pageNumber: .constant(1))
}
