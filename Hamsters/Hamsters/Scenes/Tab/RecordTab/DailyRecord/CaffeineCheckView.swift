//
//  CaffeineCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

enum CaffeineIntake {
    case intake
    case not
}

struct CaffeineCheckView: View {
    @Binding var pageNumber: Int
    @Binding var amountOfCaffein: Int
    
    @State private var isSelected: [Bool] = Array(repeating: false, count: 10)
    @State private var isTaken: CaffeineIntake?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 카페인 ☕️️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            HStack(spacing: 13) {
                Button {
                    isTaken = .intake
                } label: {
                    Text("마심")
                        .font(.headline)
                        .foregroundStyle(isTaken == .intake ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(isTaken == .intake ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
                
                Button {
                    isTaken = .not
                    amountOfCaffein = 0
                } label: {
                    Text("안마심")
                        .font(.headline)
                        .foregroundStyle(isTaken == .not ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(isTaken == .not ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)

            if isTaken == .intake {
                VStack(alignment: .leading, spacing: 16) {
                    Text("얼마나 드셨나요?")
                        .font(.headline)
                        .foregroundStyle(.thoNavy)
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 5)) {
                        ForEach(0..<10, id: \.self) { index in
                            Button {
                                if isSelected[index] {
                                    isSelected = Array(repeating: false, count: 10)
                                }
                                if amountOfCaffein == (index + 1) {
                                    amountOfCaffein = 0
                                } else {
                                    for i in 0...index {
                                        isSelected[i] = true
                                    }
                                    amountOfCaffein = index + 1
                                }
                            } label: {
                                Image(isSelected[index] ? "CaffeineSelected" : "CaffeineUnselected")
                                    .opacity(isSelected[index] ? 1 : 0.5)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Spacer()
            
            DailyRecordNextTwoButtons(pageNumber: $pageNumber, selectedValue: $amountOfCaffein)
        }
    }
}

#Preview {
    CaffeineCheckView(pageNumber: .constant(8), amountOfCaffein: .constant(0))
}
