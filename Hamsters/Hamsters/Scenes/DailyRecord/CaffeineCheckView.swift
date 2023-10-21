//
//  CaffeineCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct CaffeineCheckView: View {
    @Binding var pageNumber: Int
    @Binding var selectedCaffeine: Int
    @State private var isSelected = Array(repeating: false, count: 10)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 카페인 ☕️️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)

            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 5)) {
                ForEach(0..<10, id: \.self) { index in
                    Button {
                        if isSelected[index] {
                            isSelected = Array(repeating: false, count: 10)
                        }
                        for i in 0...index {
                            isSelected[i] = true
                        }
                        selectedCaffeine = index
                    } label: {
                        Image(isSelected[index] ? "CaffeineSelected" : "CaffeineUnselected")
                    }
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            DailyRecordNextTwoButtons(pageNumber: $pageNumber, selectedValue: $selectedCaffeine)
        }
    }
}

#Preview {
    CaffeineCheckView(pageNumber: .constant(8), selectedCaffeine: .constant(0))
}
