//
//  SmokingCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct SmokingCheckView: View {
    @Binding var pageNumber: Int
    @Binding var selectedPieces: Int // 최솟값 기준으로 Int 값 저장
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 흡연량 ☁️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            List {
                ForEach(SmokingAmount.allCases, id: \.self) { pcs in
                    if pcs.minValue != 0 {
                        HStack {
                            Button {
                                selectedPieces = pcs.minValue
                            } label: {
                                Text("\(pcs.minValue)~\(pcs.maxValue) 개피")
                                    .foregroundStyle(Color.primary)
                            }
                            
                            Spacer()
                            
                            if selectedPieces == pcs.minValue {
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
            
            DailyRecordNextTwoButtons(pageNumber: $pageNumber, selectedValue: $selectedPieces)
        }
    }
}

#Preview {
    SmokingCheckView(pageNumber: .constant(7), selectedPieces: .constant(0))
}
