//
//  DailyRecordNextButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/19/23.
//

import SwiftUI

struct DailyRecordNextButton: View {
    @Binding var pageNumber: Int
    @Binding var isActiveRecord: Bool
    
    let title: String
    
    var body: some View {
        Button {
            if pageNumber == 11 {
                isActiveRecord = false
            } else {
                pageNumber += 1
            }
        } label: {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(.thoNavy)
                .cornerRadius(15)
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
        }
    }
}

#Preview {
    DailyRecordNextButton(pageNumber: .constant(1), isActiveRecord: .constant(true), title: "다음")
}
