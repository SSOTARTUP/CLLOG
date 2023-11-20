//
//  WeightCheckView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import SwiftUI

struct WeightCheckView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
        
    var kgRange: [Int] = Array(1...200)
    var grRange: [Int] = Array(0...9)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("체중을 알려주세요")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 12)
                
                Text("약물 복용으로 인한 체중변화가 있을 수 있습니다.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 32)
            }
            .padding(.horizontal, 16)
            
            HStack {
                Text("\(viewModel.selectedKg)" + "." + "\(viewModel.selectedGr)" + " kg")
                    .font(.largeTitle)
                    .foregroundStyle(Color.thoGreen)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 28)
                    .background(Color.thoNavy)
                    .cornerRadius(41)
            }
            .frame(maxWidth: .infinity)
            
            // .tag picker 에 값 동기화를 위함, 이유 더 찾아보기
            HStack {
                Picker(selection: $viewModel.selectedKg, label: Text("Kilograms")) {
                    ForEach(kgRange, id: \.self) { kg in
                        Text("\(kg)").tag(kg)
                            .font(.title3)
                    }
                }
                .pickerStyle(.wheel)
                
                Text(".") // 구분점
                
                Picker(selection: $viewModel.selectedGr, label: Text("Grams")) {
                    ForEach(grRange, id: \.self) { gram in
                        Text("\(gram)").tag(gram)
                            .font(.title3)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("kg")
                    .font(.title3)
            }
            .padding(.horizontal, 68)
            .padding(.top, 34)
            .onChange(of: viewModel.selectedKg) { _ in
                updateWeight()
            }
            .onChange(of: viewModel.selectedGr) { _ in
                updateWeight()
            }
            
            
            Spacer()
            
            NextButton(title: "다음", isActive: .constant(true)) {
                if let vm = viewModel as? DailyRecordViewModel {
                    vm.goToNextPage()
                }
            }
            .padding(.bottom, 40)
        }
    }
    
    func updateWeight() {
        viewModel.weight = Double(viewModel.selectedKg) + Double(viewModel.selectedGr) / 10.0
    }
}

#Preview {
    WeightCheckView(viewModel: DailyRecordViewModel())
}
