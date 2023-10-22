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
        ProgressView(value: Double(pageNumber), total: 11)
            .tint(.thoNavy)
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
    }
}

#Preview {
    DailyRecordProgressBar(pageNumber: .constant(1))
}
