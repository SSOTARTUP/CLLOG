//
//  NextButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

struct NextButton: View {
    @Binding var isActive: Bool
    var body: some View {
        Text("다음")
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(isActive ? .white : .thoNavy)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(isActive ? .thoNavy : .thoDisabled)
            .cornerRadius(15)
    }
}

#Preview {
    NextButton(isActive: .constant(false))
}
