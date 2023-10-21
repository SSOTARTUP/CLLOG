//
//  AddMedicineView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import SwiftUI

struct AddMedicineView: View {
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isInputFocused: Bool  // 포커스 상태를 추적합니다.
    
//    @StateObject private var medicineViewModel = MedicineViewModel()
    @EnvironmentObject var medicineViewModel: MedicineViewModel
    @StateObject private var alarmModel = AlarmViewModel()
    
    @Binding var isActiveNext: Bool
    
    @State var medicineName = ""
    @State var capacity = ""
    @State private var fullCapacityText = ""
    @State private var selectedMediIndex: Int = 0
    
    // option .asneeded 나중에 알람 설정 시 매일로 할 필요 존재
    private var sortedDaysString: String {
        // 선택된 요일들을 '월, 화, 수...' 순서로 정렬합니다.
        let sortedDays = selectedDays.sorted()
        let weekedns: [Day] = [.saturday, .sunday]
        
        if selectedOption == .specificDay {
            if sortedDays == weekedns {
                return "주말"
            }
            
            if sortedDays.count == 7 {
                return "매일"
            }
        }
        
        if selectedOption == .asNeeded {
            return "필요 시"
        }
        
        // 정렬된 요일들을 문자열로 변환합니다.
        return sortedDays.isEmpty ? "선택 안됨" : sortedDays.map { $0.rawValue }.joined(separator: ", ")
    }
    
    // 빈도로 부터 오는 값들 - 시작일, 알람 선택 날짜
    @State var startDay: Date = Date()
    @State private var selectedDays: [Day] = []
    @State private var selectedOption: Option? = nil
    
    
    let mediCapacity = ["정", "mg", "mcg", "mL", "g", "%"]
    let mediColumn = Array(repeating: GridItem(.flexible(), spacing: 6), count: 3)
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    // MARK: - function
    private func addAlarm() {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 8 // 오전 8시로 설정합니다.
        dateComponents.minute = 0
        
        // 이 시간을 기반으로 다음 오전 8시로 설정된 날짜/시간 객체를 생성합니다.
        if let defaultAlarmTime = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .nextTime) {
            alarmModel.addAlarmTime(date: defaultAlarmTime)
        }
    }
    
    // 용량 입력이나 약 단위 선택이 변경될 때 마다 호출될 수 있는 함수.
    private func updateFullCapacityText() {
        if selectedMediIndex < mediCapacity.count {
            let unit = mediCapacity[selectedMediIndex]  // 선택된 단위.
            fullCapacityText = "\(capacity)\(unit)"  // 용량과 단위를 결합합니다.
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 0) {
                    Image(systemName: "stethoscope")
                        .font(.system(size: 42))
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    Text("투여약 추가")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 48)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("약 이름")
                            .font(.headline)
                            .foregroundStyle(.thoNavy)
                            .padding(.leading, 8)
                            .padding(.bottom, 6)
                        TextField("약 이름 입력", text: $medicineName)
                            .focused($isInputFocused)
                            .font(.body)
                            .padding(.vertical, 11)
                            .padding(.leading, 8)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.bottom, 28)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("완료") {
                                        isInputFocused = false
                                    }
                                }
                            }
                        
                        
                        Text("용량")
                            .font(.headline)
                            .foregroundStyle(.thoNavy)
                            .padding(.leading, 8)
                            .padding(.bottom, 6)
                        TextField("용량 추가", text: $capacity)
                            .focused($isInputFocused)
                            .keyboardType(.numberPad)
                            .font(.body)
                            .padding(.vertical, 11)
                            .padding(.leading, 8)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.bottom, 18)
                            .onChange(of: selectedMediIndex) { newValue in
                                // 단위가 변경될 때마다 fullCapacityText 업데이트.
                                updateFullCapacityText()
                            }
                                                
                        LazyVGrid(columns: mediColumn) {
                            ForEach(0..<6) { index in
                                Button(action: {
                                    selectedMediIndex = index
                                }, label: {
                                    Text("\(mediCapacity[index])")
                                        .font(.body)
                                        .foregroundStyle(selectedMediIndex == index ? Color.white : Color.thoNavy) // 선택된 버튼은 다른 색상을 가집니다.
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 15)
                                        .background(selectedMediIndex == index ? Color.thoNavy : Color.thoDisabled) // 선택된 버튼은 다른 배경을 가집니다.
                                        .cornerRadius(13)
                                })
                                
                            }
                        }
                        .padding(.bottom, 48)
                        
                        
                        NavigationLink(destination: AlarmFrequencyView(selectedOption: $selectedOption, selectedDays: $selectedDays, startDay: $startDay)) {
                            HStack {
                                Text("빈도")
                                    .foregroundStyle(.black)
                                
                                Spacer()
                                
                                Text("\(sortedDaysString)")
                                    .foregroundStyle(.thoNavy)
                            }
                            .font(.body)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                        }
                        .padding(.bottom, 6)
                        
                        Text("약을 투여할 시간을 지정하시면 해당 시간에 맞춰 알람을 보냅니다.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 28)
                        
                        
                        Text("시간")
                            .font(.headline)
                            .foregroundStyle(.thoNavy)
                            .padding(.leading, 8)
                            .padding(.bottom, 6)
                        
                        
                        // 시간 추가
                        VStack(alignment: .leading, spacing: 0) {
                            
                            ForEach(Array(zip(0..<alarmModel.alarms.count, alarmModel.alarms)), id: \.0) { index, alarm in
                                
                                //                                AlarmRow(alarm: $alarmModel.alarms[alarm])
                                // 위 코드랑 다르게 alarm 객체를 alarms 배열에서 찾기위해 firstindex(where) 메서드를 사용
                                // alarm 객체의 id가 배열 내의 객체의 id와 일치하는 경우 첫번째 인덱스 반환
                                
                                if index > 0 {
                                    Divider()
                                }
                                
                                AlarmRow(alarm: $alarmModel.alarms[alarmModel.alarms.firstIndex(where: { $0.id == alarm.id })!], removeAction: {
                                    if let index = alarmModel.alarms.firstIndex(where: { $0.id == alarm.id }) {
                                        // 인덱스를 사용하여 알람을 삭제합니다.
                                        alarmModel.removeAlarmTime(at: index)
                                    }
                                })
                            }
                            
                            if alarmModel.alarms.count > 0 {
                                Divider()
                            }
                            
                            Button(action: {
                                addAlarm()
                                print(alarmModel.alarms)
                            }, label: {
                                HStack(spacing: 13){
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundStyle(.thoNavy)
                                    Text("시간 추가")
                                    Spacer()
                                }
                                .font(.body)
                            })
                            .padding(16)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("뒤로")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                        guard !medicineName.isEmpty,
                              !capacity.isEmpty
                            else {
                            // 하나 이상의 필수 입력 필드가 누락된 경우 작업을 중단합니다.
                            // 필요에 따라 사용자에게 경고 메시지를 표시할 수 있습니다.
                            print("실패")
                            return
                        }
                        
                        medicineViewModel.addMedicine(name: medicineName, capacity: capacity, frequency: selectedDays, unit: mediCapacity[selectedMediIndex], startDay: startDay, alarms: alarmModel.alarms, sortedDays: sortedDaysString)
                        // 용량 + unit = fullycapacityText
                        print(medicineViewModel.medicines)
                        isActiveNext = true
                        dismiss()
                    }, label: {
                        Text("완료")
                    })
                }
            }
        }
    }
    
}

#Preview {
    AddMedicineView(isActiveNext: .constant(true))
}
