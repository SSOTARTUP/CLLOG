//
//  DrinkCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct DrinkCheckView: View {
    @ObservedObject var dailyRecordViewModel: DailyRecordViewModel
//    @Binding var pageNumber: Int
//    @Binding var amountOfAlcohol: Int // 최댓값 기준으로 Int 값 저장
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 음주량 🍻")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            List {
                Section {
                    Button {
                        dailyRecordViewModel.amountOfAlcohol = 0
                    } label: {
                        HStack {
                            Text("오늘은 마시지 않았어요!")
                                .foregroundStyle(Color.primary)
                            
                            Spacer()
                            
                            if dailyRecordViewModel.amountOfAlcohol == 0 {
                                Image(systemName: "checkmark")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.thoNavy)
                            }
                        }
                    }
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
                
                Section(footer: Text("음주량은 소주를 기준으로 합니다.")) {
                    ForEach(DrinkAmount.allCases, id: \.self) { bottle in
                        if bottle != .max0 {
                            HStack {
                                Button {
                                    dailyRecordViewModel.amountOfAlcohol = bottle.maxValue
                                } label: {
                                    Text(bottle.title)
                                        .foregroundStyle(Color.primary)
                                }
                                
                                Spacer()
                                
                                if dailyRecordViewModel.amountOfAlcohol == bottle.maxValue {
                                    Image(systemName: "checkmark")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.thoNavy)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(uiColor: .systemGroupedBackground))
                }
            }
            .padding(.top, -15) // list 기본 padding 제거
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            Spacer()
            
            NextButton(title: "다음", isActive: .constant(true)) {
                dailyRecordViewModel.goToNextPage()
            }
            
//            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord: .constant(true), title: "다음")
        }
    }
}

#Preview {
    DrinkCheckView(dailyRecordViewModel: DailyRecordViewModel())
}
