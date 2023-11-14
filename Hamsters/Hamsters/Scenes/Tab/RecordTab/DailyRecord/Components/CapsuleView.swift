//
//  CapsuleView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import SwiftUI

struct CapsuleView: View {
    let text: String
    var isSelected: Bool
    
    let action: () -> Void
    
    var body: some View {
        Text(text)
            .font(.body)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? Color.thoNavy : Color.thoDisabled)
            )
            .foregroundColor(isSelected ? Color.white : Color.secondary)
            .onTapGesture(perform: action)
    }
}

#Preview {
    CapsuleView(text: "없음", isSelected: false, action: { print("select") })
}
