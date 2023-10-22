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
        VStack(alignment: .leading, spacing: 20) {
            Text("추가로 기록하고싶은\n내용이 있나요? ✍️️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            TextEditor(text: $memo)
                .scrollContentBackground(.hidden)
                .background {
                    TextEditor(text: .constant(memo.isEmpty ? placeholder : ""))
                        .foregroundStyle(.gray)
                        .scrollContentBackground(.hidden)
                        .background(Color(uiColor: .secondarySystemBackground))
                }
//                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                
            Spacer()
            
            DailyRecordNextButton(pageNumber: $pageNumber, title: "입력 완료")
                .padding(.bottom, 30)
        }
    }
}

#Preview {
    AdditionalMemoView(pageNumber: .constant(10), memo: .constant("메모~"))
}
