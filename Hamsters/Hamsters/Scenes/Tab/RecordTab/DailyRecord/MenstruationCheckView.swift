//
//  MenstruationCheckView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import SwiftUI

struct MenstruationCheckView: View {
    @Binding var pageNumber: Int
    @State private var selectedMt: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("월경중이신가요?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 37)
            
            HStack(spacing: 13) {
                Button(action: {
                    selectedMt = true
                }, label: {
                    Text("예")
                        .font(.headline)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(selectedMt == true ? Color.thoNavy : Color.thoDisabled)
                        .foregroundColor(selectedMt == true ? Color.white : Color.thoNavy)
                        .cornerRadius(15)
                })
                
                Button(action: {
                    selectedMt = false
                }, label: {
                    Text("아니오")
                        .font(.headline)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(selectedMt == false ? Color.thoNavy : Color.thoDisabled)
                        .foregroundColor(selectedMt == false ? Color.white : Color.thoNavy)
                        .cornerRadius(15)
                })
            }
            .padding(.horizontal, 8)
            
            Spacer()
            
            DailyRecordNextButton(pageNumber: $pageNumber, title: "다음")
                .padding(.bottom, 30)
            
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MenstruationCheckView(pageNumber: .constant(12))
}
