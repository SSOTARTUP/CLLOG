//
//  DailyRecordNextTwoButtons.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct DailyRecordNextTwoButtons: View {
    @Binding var pageNumber: Int
    @Binding var selectedValue: Int
    
    var body: some View {
        HStack(spacing: 13) {
            Button {
                pageNumber += 1
                selectedValue = 0
            } label: {
                Text("해당 없음")
                    .font(.headline)
                    .foregroundStyle(.thoNavy)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.thoDisabled)
                    .cornerRadius(15)
            }
            
            Button {
                pageNumber += 1
            } label: {
                Text("다음")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.thoNavy)
                    .cornerRadius(15)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
    }
}

#Preview {
    DailyRecordNextTwoButtons(pageNumber: .constant(1), selectedValue: .constant(0))
}
