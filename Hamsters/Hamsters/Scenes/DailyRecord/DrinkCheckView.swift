//
//  DrinkCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct DrinkCheckView: View {
    @Binding var pageNumber: Int
    @Binding var amountOfAlcohol: Int // 최댓값 기준으로 Int 값 저장
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 음주량 🍻")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            List {
                ForEach(DrinkAmount.allCases, id: \.self) { bottle in
                    if bottle.maxValue != 0 {
                        HStack {
                            Button {
                                amountOfAlcohol = bottle.maxValue
                            } label: {
                                if bottle.maxValue == 5 {
                                    Text("\(bottle.maxValue)병 이상")
                                        .foregroundStyle(Color.primary)
                                } else if bottle.maxValue == 1 {
                                    Text("\(bottle.maxValue)병 미만")
                                        .foregroundStyle(Color.primary)
                                } else {
                                    Text("\(bottle.minValue)~\(bottle.maxValue) 병")
                                        .foregroundStyle(Color.primary)
                                }
                            }
                            
                            Spacer()
                            
                            if amountOfAlcohol == bottle.maxValue {
                                Image(systemName: "checkmark")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.thoNavy)
                            }
                        }
                    }
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
            }
            .padding(.top, -15) // list 기본 padding 제거
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            Spacer()
            
            DailyRecordNextTwoButtons(pageNumber: $pageNumber, selectedValue: $amountOfAlcohol)
        }
    }
}

#Preview {
    DrinkCheckView(pageNumber: .constant(9), amountOfAlcohol: .constant(0))
}
