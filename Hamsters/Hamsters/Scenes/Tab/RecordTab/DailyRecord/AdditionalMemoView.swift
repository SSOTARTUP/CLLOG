//
//  MemoView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct AdditionalMemoView: View {
    @Binding var pageNumber: Int
    @Binding var memo: String
    
    let placeholder = "있다면 자유롭게 입력해 주세요"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("추가로 기록하고싶은\n내용이 있나요? ✍️️")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 16)
                
                TextEditor(text: $memo)
                    .scrollContentBackground(.hidden)
                    .background {
                        TextEditor(text: .constant(memo.isEmpty ? placeholder : ""))
                            .foregroundStyle(.gray)
                            .scrollContentBackground(.hidden)
                            .background(Color(uiColor: .secondarySystemBackground))
                    }
                    .frame(height: screenBounds().height * 0.35)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .onChange(of: memo) { _ in
                        if memo.count > 500 {
//                            characterLimitWarning = true
                            memo = String(memo.prefix(7))
                        } else if memo.count < 7 {
//                            characterLimitWarning = false
                        }
                    }
                
                HStack {
                    Spacer()
                    
                    Text("\(memo.count) / 500")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 16)

            Spacer()
            
            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord:.constant(true), title: "\(Image(systemName: "checkmark.circle.fill")) 입력 완료")
        }
    }
}

#Preview {
    AdditionalMemoView(pageNumber: .constant(10), memo: .constant("메모~"))
}
