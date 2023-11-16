//
//  MemoView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct AdditionalMemoView: View {
    @ObservedObject var dailyRecordViewModel: DailyRecordViewModel
//    @Binding var pageNumber: Int
//    @Binding var memo: String
    
    let placeholder = "있다면 자유롭게 입력해 주세요"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("추가로 기록하고싶은\n내용이 있나요? ✍️️")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 16)
                
                TextEditor(text: $dailyRecordViewModel.memo)
                    .scrollContentBackground(.hidden)
                    .background {
                        TextEditor(text: .constant(dailyRecordViewModel.memo.isEmpty ? placeholder : ""))
                            .foregroundStyle(.gray)
                            .scrollContentBackground(.hidden)
                            .background(Color(uiColor: .secondarySystemBackground))
                    }
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .onChange(of: dailyRecordViewModel.memo) { _ in
                        if dailyRecordViewModel.memo.count > 500 {
//                            characterLimitWarning = true
                            dailyRecordViewModel.memo = String(dailyRecordViewModel.memo.prefix(500))
                        } else if dailyRecordViewModel.memo.count < 500 {
//                            characterLimitWarning = false
                        }
                    }
                
                HStack {
                    Spacer()
                    
                    Text("\(dailyRecordViewModel.memo.count) / 500")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                .padding(.bottom, 50)
            }
            .padding(.horizontal, 16)

            Spacer()
            
            NextButton(title: "다음", isActive: .constant(true)) {
                dailyRecordViewModel.goToNextPage()
            }
            
//            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord:.constant(true), title: "\(Image(systemName: "checkmark.circle.fill")) 입력 완료")
        }
    }
}

#Preview {
    AdditionalMemoView(dailyRecordViewModel: DailyRecordViewModel())
}
