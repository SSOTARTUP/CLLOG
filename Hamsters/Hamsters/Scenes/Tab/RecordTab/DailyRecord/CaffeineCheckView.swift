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
    @ObservedObject var dailyRecordViewModel: DailyRecordViewModel
    
//    @Binding var pageNumber: Int
//    @Binding var amountOfCaffein: Int
    
//    @State private var isSelected: [Bool] = Array(repeating: false, count: 10)
//    @State private var isTaken: CaffeineIntake?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 카페인 ☕️️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            HStack(spacing: 13) {
                Button {
                    dailyRecordViewModel.isTaken = .intake
                } label: {
                    Text("마심")
                        .font(.headline)
                        .foregroundStyle(dailyRecordViewModel.isTaken == .intake ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(dailyRecordViewModel.isTaken == .intake ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
                
                Button {
                    dailyRecordViewModel.isTaken = .not
                    dailyRecordViewModel.amountOfCaffein = 0
                } label: {
                    Text("안마심")
                        .font(.headline)
                        .foregroundStyle(dailyRecordViewModel.isTaken == .not ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(dailyRecordViewModel.isTaken == .not ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)

            if dailyRecordViewModel.isTaken == .intake {
                VStack(alignment: .leading, spacing: 16) {
                    Text("얼마나 드셨나요?")
                        .font(.headline)
                        .foregroundStyle(.thoNavy)
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 5)) {
                        ForEach(0..<10, id: \.self) { index in
                            Button {
                                if dailyRecordViewModel.isSelected[index] {
                                    dailyRecordViewModel.isSelected = Array(repeating: false, count: 10)
                                }
                                if dailyRecordViewModel.amountOfCaffein == (index + 1) {
                                    dailyRecordViewModel.amountOfCaffein = 0
                                } else {
                                    for i in 0...index {
                                        dailyRecordViewModel.isSelected[i] = true
                                    }
                                    dailyRecordViewModel.amountOfCaffein = index + 1
                                }
                            } label: {
                                Image(dailyRecordViewModel.isSelected[index] ? "CaffeineSelected" : "CaffeineUnselected")
                                    .opacity(dailyRecordViewModel.isSelected[index] ? 1 : 0.5)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Spacer()
            
            NextButton(title: "다음", isActive: .constant(true)) {
                dailyRecordViewModel.goToNextPage()
            }
            .padding(.bottom, 40)
//            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord: .constant(true), title: "다음")
        }
    }
}

#Preview {
    CaffeineCheckView(dailyRecordViewModel: DailyRecordViewModel())
}
