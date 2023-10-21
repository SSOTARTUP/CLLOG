//
//  DrinkCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct DrinkCheckView: View {
    @Binding var pageNumber: Int
    @Binding var selectedBottles: Int // 최솟값 기준으로 Int 값 저장
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 음주량 🍻")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            List {
                ForEach(DrinkAmount.allCases, id: \.self) { bottle in
                    HStack {
                        Button {
                            selectedBottles = bottle.minValue
                        } label: {
                            if bottle.minValue == 5 {
                                Text("\(bottle.minValue)병 이상")
                                    .foregroundStyle(Color.primary)
                            } else {
                                Text("\(bottle.minValue)~\(bottle.maxValue) 병")
                                    .foregroundStyle(Color.primary)
                            }
                        }
                        
                        Spacer()
                        
                        if selectedBottles == bottle.minValue {
                            Image(systemName: "checkmark")
                                .fontWeight(.bold)
                                .foregroundStyle(.thoNavy)
                        }
                    }
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
            }
            .padding(.top, -15) // list 기본 padding 제거
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            Spacer()
            
            DailyRecordNextTwoButtons(pageNumber: $pageNumber, selectedValue: $selectedBottles)
        }
    }
}

#Preview {
    DrinkCheckView(pageNumber: .constant(9), selectedBottles: .constant(0))
}
