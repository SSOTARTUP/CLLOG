//
//  DailyRecordNextButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/19/23.
//

import SwiftUI

struct DailyRecordNextButton: View {
//    @Binding var isActive: Bool
    @Binding var pageNumber: Int
    
    var body: some View {
        Button {
            pageNumber += 1
        } label: {
            Text("다음")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(.thoNavy)
                .cornerRadius(15)
                .padding(.horizontal, 16)
        }
//        .disabled(!isActive)
    }
}

#Preview {
    DailyRecordNextButton(pageNumber: .constant(1))
}