//
//  DrinkCheckView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import SwiftUI

struct DrinkCheckView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let _ = viewModel as? DailyRecordViewModel {
                Text("오늘의 음주량 🍻")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
            }
            
            List {
                Section {
                    Button {
                        viewModel.amountOfAlcohol = 0
                    } label: {
                        HStack {
                            Text("오늘은 마시지 않았어요!")
                                .foregroundStyle(Color.primary)
                            
                            Spacer()
                            
                            if viewModel.amountOfAlcohol == 0 {
                                Image(systemName: "checkmark")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.thoNavy)
                            }
                        }
                    }
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
                
                Section(footer: Text("음주량은 소주를 기준으로 합니다.")) {
                    ForEach(DrinkAmount.allCases, id: \.self) { bottle in
                        if bottle != .max0 {
                            HStack {
                                Button {
                                    viewModel.amountOfAlcohol = bottle.maxValue
                                } label: {
                                    Text(bottle.title)
                                        .foregroundStyle(Color.primary)
                                }
                                
                                Spacer()
                                
                                if viewModel.amountOfAlcohol == bottle.maxValue {
                                    Image(systemName: "checkmark")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.thoNavy)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(uiColor: .systemGroupedBackground))
                }
            }
            .padding(.top, -15) // list 기본 padding 제거
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            Spacer()
            
            NextButton(title: ((viewModel as? DailyRecordViewModel) != nil) ? "다음" : "확인", isActive: .constant(true)) {
                viewModel.bottomButtonClicked()
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    DrinkCheckView(viewModel: DailyRecordViewModel())
}
