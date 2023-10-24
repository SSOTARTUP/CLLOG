//
//  WeightCheckView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import SwiftUI

struct WeightCheckView: View {
    @Binding var pageNumber: Int
    
    @Binding var selectedKg: Int
    @Binding var selectedGr: Int
    
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
                        .padding(.bottom, 16)
                }
                .padding(.horizontal, 16)
                
                // .tag picker 에 값 동기화를 위함, 이유 더 찾아보기
                HStack {
                    Picker(selection: $selectedKg, label: Text("Kilograms")) {
                        ForEach(kgRange, id: \.self) { kg in
                            Text("\(kg)").tag(kg)
                                .font(.title)
                                .bold()
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Text(".") // 구분점
                    
                    Picker(selection: $selectedGr, label: Text("Grams")) {
                        ForEach(grRange, id: \.self) { gram in
                            Text("\(gram)").tag(gram)
                                .font(.title)
                                .bold()
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Text("kg")
                        .font(.title)
                        .bold()
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                Spacer()
                
                HStack {
                    Text("\(selectedKg)" + "." + "\(selectedGr)" + "kg")
                        .font(.title)
                        .foregroundStyle(Color.secondary)
                        .bold()
                        .padding(10)
                        .background(Color.thoDisabled)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            
            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord:.constant(true), title: "다음")
            
        }
    }
}

#Preview {
    WeightCheckView(pageNumber: .constant(11), selectedKg: .constant(50), selectedGr: .constant(0))
}
