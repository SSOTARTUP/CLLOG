//
//  NextButton.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/8/23.
//

import SwiftUI

struct NextButton: View {
    var title: String
    @Binding var isActive: Bool
    var closure: () -> Void

    var body: some View {
        Button {
            closure()
        } label: {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(isActive ? .white : .thoNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(isActive ? .thoNavy : .thoDisabled)
                .cornerRadius(15)
                .padding(.horizontal,24)
        }
    }
}
