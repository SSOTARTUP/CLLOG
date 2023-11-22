//
//  QuestionItemEditView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/19/23.
//

import SwiftUI

struct QuestionItemEditView: View {
    @StateObject var viewModel = MyInfoViewModel()
    
    let selectedSex = SexClassification(rawValue: UserDefaults.standard.string(forKey: UserDefaultsKey.hamsterName.rawValue) ?? "female")
    
    var body: some View {
        List {
            Section {
                if selectedSex != .male {
                    Toggle(isOn: $viewModel.onPeriod) {
                        Text("월경 여부")
                    }
                }
                
                Toggle(isOn: $viewModel.onCaffeine) {
                    Text("카페인량")
                }
                
                Toggle(isOn: $viewModel.onSmoking) {
                    Text("흡연량")
                }
                
                Toggle(isOn: $viewModel.onDrink) {
                    Text("음주량")
                }
            } header: {
                Text("편집할 항목을 선택하세요")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.thoNavy)
                    .padding(.leading, -16)
            } footer: {
                Text("비활성화 시 더 이상 기록하기 화면에서 표시되지 않지만,\n다이어리 화면에서는 이전의 기록을 계속 보실 수 있습니다.")
            }
            .listRowBackground(Color.thoTextField)

        }
        .onDisappear {
            viewModel.savePages()
            viewModel.saveSettings()
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("질문 항목 편집")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    QuestionItemEditView()
}
