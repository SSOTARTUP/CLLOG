//
//  AlarmFrequencyView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/17/23.
//

import SwiftUI

struct AlarmFrequencyView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedOption: Option
    @Binding var selectedDays: [Day]
    
    // 초기 값을 저장하는 @State 프로퍼티를 선언합니다.
      @State private var initialSelectedOption: Option
      @State private var initialSelectedDays: [Day]
      
      // 뷰가 초기화될 때 @State 프로퍼티에 바인딩된 값을 저장합니다.
      init(selectedOption: Binding<Option>, selectedDays: Binding<[Day]>) {
          _selectedOption = selectedOption
          _selectedDays = selectedDays
          _initialSelectedOption = State(initialValue: selectedOption.wrappedValue)
          _initialSelectedDays = State(initialValue: selectedDays.wrappedValue)
      }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(zip(0..<Option.allCases.count, Option.allCases)), id: \.0) { index, option in
                    
                    if index > 0 {
                        Divider()
                    }
                    
                    HStack {
                        Text("\(option.rawValue)")
                            .font(.body)
                        
                        Spacer()
                        
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                                .font(.headline)
                                .foregroundStyle(.blue)
                            
                        }
                    }
                    .padding(.vertical, 14)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if index == 0 {
                           selectedOption = option
                        } else {
                            selectedOption = option
                           selectedDays.removeAll()
                        }
                    }
                }
                .padding(.horizontal, 16)
                .background(Color(uiColor: .secondarySystemBackground))
            }
            .cornerRadius(10)
            .padding(.top, 24)
            .padding(.bottom, 44)
            
            if selectedOption == Option.specificDay {
                Text("요일 선택")
                    .font(.headline)
                    .foregroundStyle(.thoNavy)
                    .padding(.leading, 8)
                    .padding(.bottom, 6)
                
                HStack(spacing: 0) {
                    ForEach(Day.allCases, id: \.self) { day in
                        Text(String(day.rawValue.first!))
                            .font(.title3)
                            .foregroundStyle(selectedDays.contains(day) ? Color.white : Color.black)
                            .padding(14)
                            .background(
                                Circle()
                                    .fill(selectedDays.contains(day) ? Color.thoNavy : Color.clear)
                            )
                        
                            .onTapGesture {
                                if selectedDays.contains(day) {
                                    selectedDays.removeAll(where: {$0 == day})
                                } else {
                                    selectedDays.append(day)
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .padding(.bottom, 44)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationTitle("빈도")
        .navigationBarBackButtonHidden()
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    selectedOption = initialSelectedOption
                    selectedDays = initialSelectedDays
                    dismiss()
                }, label: {
                    Text("뒤로")
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("완료")
                })
            }
        }
        
    }
    
}

#Preview {
    AlarmFrequencyView(selectedOption: .constant(.specificDay),
                       selectedDays:.constant([.monday, .wednesday]))

}
