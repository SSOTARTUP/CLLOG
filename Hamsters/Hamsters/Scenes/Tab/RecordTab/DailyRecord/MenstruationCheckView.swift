//
//  MenstruationCheckView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import SwiftUI

struct MenstruationCheckView: View {
    @ObservedObject var dailyRecordViewModel: DailyRecordViewModel
//    @Binding var pageNumber: Int
//    @Binding var isPeriod: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("월경중이신가요?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 37)
                
                HStack(spacing: 13) {
                    Button(action: {
                        dailyRecordViewModel.isPeriod = true
                    }, label: {
                        Text("예")
                            .font(.headline)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(dailyRecordViewModel.isPeriod == true ? Color.thoNavy : Color.thoDisabled)
                            .foregroundColor(dailyRecordViewModel.isPeriod == true ? Color.white : Color.thoNavy)
                            .cornerRadius(15)
                    })
                    
                    Button(action: {
                        dailyRecordViewModel.isPeriod = false
                    }, label: {
                        Text("아니오")
                            .font(.headline)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(dailyRecordViewModel.isPeriod == false ? Color.thoNavy : Color.thoDisabled)
                            .foregroundColor(dailyRecordViewModel.isPeriod == false ? Color.white : Color.thoNavy)
                            .cornerRadius(15)
                    })
                }
                .padding(.horizontal, 8)
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            NextButton(title: "다음", isActive: .constant(true)) {
                dailyRecordViewModel.goToNextPage()
            }
//            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord:.constant(true), title: "다음")
            
        }
    }
}

#Preview {
    MenstruationCheckView(dailyRecordViewModel: DailyRecordViewModel())
}
