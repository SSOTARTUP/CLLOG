//
//  RecordMainView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct RecordMainView: View {
    @State private var today = Date.now
    @State private var isActiveSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(today, formatter: Self.dateFormatter)
                
                Text("오늘")
                    .fontWeight(.semibold)
            }
            .font(.system(size: 17))
            .padding()
            
            VStack(spacing: 20) {
                WeeklyMedicationCalendar()
                
                Spacer()
                
                Image("GrayHamster")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 146)
                    .padding(.bottom, 20)
                
                Button {
                    isActiveSheet = true
                } label: {
                    Text("오늘의 상태 추가하기")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(.thoNavy)
                        .cornerRadius(12)
                        .padding(.horizontal, 61)
                }
                
                HStack {
                    Text("복용 체크")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Group {
                        Text("추가")
                        
                        Divider()
                            .frame(height: 20)
                        
                        Text("수정")
                    }
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                
                DailyMedicationList()
                    .padding(.bottom, 36)
            }
        }
        .fullScreenCover(isPresented: $isActiveSheet) {
            DailyRecordView(isActiveSheet: $isActiveSheet)
        }
    }
}

extension RecordMainView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter
    }()
}

#Preview {
    RecordMainView()
}

