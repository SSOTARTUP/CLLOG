//
//  SmokingCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct SmokingCheckView: View {
    @ObservedObject var dailyRecordViewModel: DailyRecordViewModel
    
//    @Binding var pageNumber: Int
//    @Binding var amountOfSmoking: Int // 최솟값 기준으로 Int 값 저장
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 흡연량 ☁️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            List {
                Section {
                    Button {
                        dailyRecordViewModel.amountOfSmoking = 0
                    } label: {
                        HStack {
                            Text("오늘은 흡연하지 않았어요!")
                                .foregroundStyle(Color.primary)
                            
                            Spacer()
                            
                            if dailyRecordViewModel.amountOfSmoking == 0 {
                                Image(systemName: "checkmark")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.thoNavy)
                            }
                        }
                    }
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
                
                ForEach(SmokingAmount.allCases, id: \.self) { pcs in
                    if pcs != .min0 {
                        HStack {
                            Button {
                                dailyRecordViewModel.amountOfSmoking = pcs.minValue
                            } label: {
                                Text(pcs.title)
                                    .foregroundStyle(Color.primary)
                            }
                            
                            Spacer()
                            
                            if dailyRecordViewModel.amountOfSmoking == pcs.minValue {
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
            
            NextButton(title: "다음", isActive: .constant(true)) {
                dailyRecordViewModel.goToNextPage()
            }
            
//            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord: .constant(true), title: "다음")
        }
    }
}

#Preview {
    SmokingCheckView(dailyRecordViewModel: DailyRecordViewModel())
}
