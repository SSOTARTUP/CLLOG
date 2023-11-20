//
//  DailyRecordProgressBar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI

struct DailyRecordProgressBar: View {
    var pageNumber: Int
    var total:Int
    
    var body: some View {
        ProgressView(value: Double(pageNumber+1), total: Double(total))
            .tint(.thoNavy)
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
    }
}

#Preview {
    DailyRecordProgressBar(pageNumber: 1, total: 11)
}
