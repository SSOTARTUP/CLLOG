//
//  SmokingCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct SmokingCheckView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    

    
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
                        viewModel.amountOfSmoking = 0
                    } label: {
                        HStack {
                            Text("오늘은 흡연하지 않았어요!")
                                .foregroundStyle(Color.primary)
                            
                            Spacer()
                            
                            if viewModel.amountOfSmoking == 0 {
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
                                viewModel.amountOfSmoking = pcs.minValue
                            } label: {
                                Text(pcs.title)
                                    .foregroundStyle(Color.primary)
                            }
                            
                            Spacer()
                            
                            if viewModel.amountOfSmoking == pcs.minValue {
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
    SmokingCheckView(viewModel: DailyRecordViewModel())
}
