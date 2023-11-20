//
//  CaffeineCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

enum CaffeineIntake {
    case intake
    case not
}

struct CaffeineCheckView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    
//    @Binding var pageNumber: Int
//    @Binding var amountOfCaffein: Int
    
//    @State private var isSelected: [Bool] = Array(repeating: false, count: 10)
//    @State private var isTaken: CaffeineIntake?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 카페인 ☕️️")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            HStack(spacing: 13) {
                Button {
                    viewModel.isTaken = .intake
                } label: {
                    Text("마심")
                        .font(.headline)
                        .foregroundStyle(viewModel.isTaken == .intake ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isTaken == .intake ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
                
                Button {
                    viewModel.isTaken = .not
                    viewModel.amountOfCaffein = 0
                } label: {
                    Text("안마심")
                        .font(.headline)
                        .foregroundStyle(viewModel.isTaken == .not ? .white : .thoNavy)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isTaken == .not ? .thoNavy : .thoDisabled)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)

            if viewModel.isTaken == .intake {
                VStack(alignment: .leading, spacing: 16) {
                    Text("얼마나 드셨나요?")
                        .font(.headline)
                        .foregroundStyle(.thoNavy)
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 5)) {
                        ForEach(0..<10, id: \.self) { index in
                            Button {
                                if viewModel.isSelected[index] {
                                    viewModel.isSelected = Array(repeating: false, count: 10)
                                }
                                if viewModel.amountOfCaffein == (index + 1) {
                                    viewModel.amountOfCaffein = 0
                                } else {
                                    for i in 0...index {
                                        viewModel.isSelected[i] = true
                                    }
                                    viewModel.amountOfCaffein = index + 1
                                }
                            } label: {
                                Image(viewModel.isSelected[index] ? "CaffeineSelected" : "CaffeineUnselected")
                                    .opacity(viewModel.isSelected[index] ? 1 : 0.5)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Spacer()
            
            NextButton(title: "다음", isActive: .constant(true)) {
                if let vm = viewModel as? DailyRecordViewModel {
                    vm.goToNextPage()
                }
            }
            .padding(.bottom, 40)
//            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord: .constant(true), title: "다음")
        }
    }
}

#Preview {
    CaffeineCheckView(viewModel: DailyRecordViewModel())
}
