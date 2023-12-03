//
//  MemoView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct AdditionalMemoView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    
    let placeholder = "있다면 자유롭게 입력해 주세요"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                if let _ = viewModel as? DailyRecordViewModel {
                    Text("추가로 기록하고싶은\n내용이 있나요? ✍️️")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                }
                
                TextEditor(text: $viewModel.memo)
                    .scrollContentBackground(.hidden)
                    .background {
                        TextEditor(text: .constant(viewModel.memo.isEmpty ? placeholder : ""))
                            .foregroundStyle(.gray)
                            .scrollContentBackground(.hidden)
                            .background(Color(uiColor: .secondarySystemBackground))
                    }
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .onChange(of: viewModel.memo) { _ in
                        if viewModel.memo.count > 500 {
//                            characterLimitWarning = true
                            viewModel.memo = String(viewModel.memo.prefix(500))
                        } else if viewModel.memo.count < 500 {
//                            characterLimitWarning = false
                        }
                    }
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.memo.count) / 500")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                .padding(.bottom, 50)
            }
            .padding(.horizontal, 16)

            Spacer()
            
            NextButton(title: ((viewModel as? DailyRecordViewModel) != nil) ? "다음" : "확인", isActive: .constant(true)) {
                viewModel.bottomButtonClicked()
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    AdditionalMemoView(viewModel: DailyRecordViewModel())
}
