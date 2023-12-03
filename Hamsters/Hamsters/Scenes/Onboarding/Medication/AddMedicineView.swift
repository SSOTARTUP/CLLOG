//
//  AddMedicineView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import SwiftUI

struct AddMedicineView: View {
    @Environment(\.dismiss) private var dismiss
    
    //    @StateObject private var medicineViewModel = MedicineViewModel()
    @EnvironmentObject var medicineViewModel: MedicineViewModel
    @StateObject private var alarmModel = AlarmViewModel()
    @State private var isSaveButtonEnabled: Bool = false
    
    
    @Binding var isActiveNext: Bool
    var editingMedicine: Medicine?
    
    @FocusState private var isInputFocused: Bool  // 포커스 상태를 추적합니다.
    
    @State var medicineName = ""
    @State var capacity = ""
    @State private var fullCapacityText = ""
    @State private var selectedMediIndex: Int = 0
    
    @State private var selectedDays: [Day] = []
    @State private var selectedOption: Option = .everyDay
    @State private var alarms: [AlarmItem] = []
    
    
    let mediCapacity = ["정", "mg", "mcg", "mL", "g", "%"]
    let mediColumn = Array(repeating: GridItem(.flexible(), spacing: 6), count: 3)
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
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
        
        if selectedOption == .everyDay {
            return "매일"
        }
        
        // 정렬된 요일들을 문자열로 변환합니다.
        return sortedDays.map { $0.rawValue }.joined(separator: ", ")
    }
    
    init(isActiveNext: Binding<Bool>, editingMedicine: Medicine? = nil) {
        self._isActiveNext = isActiveNext
        self.editingMedicine = editingMedicine
        
        if let editingMedicine = editingMedicine {
            // 기존 약물을 편집하는 경우
            _medicineName = State(initialValue: editingMedicine.name)
            _capacity = State(initialValue: editingMedicine.capacity)
            _selectedMediIndex = State(initialValue: mediCapacity.firstIndex(of: editingMedicine.unit) ?? 0)
            _selectedOption = State(initialValue: editingMedicine.freOption)
            _selectedDays = State(initialValue: editingMedicine.frequency)
            _alarms = State(initialValue: editingMedicine.alarms)
            _alarmModel = StateObject(wrappedValue: AlarmViewModel(alarms: editingMedicine.alarms))
        } else {
            // 새 약물을 추가하는 경우
            _medicineName = State(initialValue: "")
            _capacity = State(initialValue: "")
            _selectedMediIndex = State(initialValue: 0)
            _selectedOption = State(initialValue: .everyDay)
            _selectedDays = State(initialValue: [])
            _alarms = State(initialValue: [])
            _alarmModel = StateObject(wrappedValue: AlarmViewModel())
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
                    
                    Text(editingMedicine != nil ? "투여약 수정" : "투여약 추가")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 48)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 6, height: 6)
                                .foregroundStyle(.red)
                            
                            Text(" 약 이름")
                                .font(.headline)
                                .foregroundStyle(editingMedicine != nil ? Color.secondary : .thoNavy)
                        }
                        //                        .padding(.leading, 8)
                        .padding(.bottom, 6)
                        
                        TextField("약 이름 입력", text: $medicineName)
                            .disabled(editingMedicine != nil)
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
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0){
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 6, height: 6)
                                    .foregroundStyle(.red)
                                Text(" 용량")
                                    .font(.headline)
                                    .foregroundStyle(editingMedicine != nil ? Color.secondary : .thoNavy)
                            }
                            //                            .padding(.leading, 8)
                            .padding(.bottom, 6)
                        }
                        TextField("용량 추가", text: $capacity)
                            .disabled(editingMedicine != nil)
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
                                .disabled(editingMedicine != nil)
                                
                            }
                        }
                        .padding(.bottom, 48)
                        
                        
                        NavigationLink(destination: AlarmFrequencyView(selectedOption: $selectedOption, selectedDays: $selectedDays)) {
                            HStack {
                                Text("빈도")
                                    .foregroundStyle(.black)
                                
                                Spacer()
                                
                                Text("\(sortedDaysString)")
                                    .foregroundStyle(.red)
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
                        
                        if selectedOption != .asNeeded {
                            Text("시간")
                                .font(.headline)
                                .foregroundStyle(.thoNavy)
                                .padding(.leading, 8)
                                .padding(.bottom, 6)
                            
                            // 시간 추가
                            VStack(alignment: .leading, spacing: 0) {
                                
                                ForEach(Array(zip(0..<alarmModel.alarms.count, alarmModel.alarms)), id: \.0) { index, alarm in
                                    
                                    if index > 0 {
                                        Divider()
                                    }
                                    
                                    AlarmRow(alarm: $alarmModel.alarms[index], removeAction: {
                                        alarmModel.removeAlarmTime(at: index)
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
                    }
                    .padding(.horizontal, 16)
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                        guard !medicineName.isEmpty, !capacity.isEmpty
                        else {
                            // 하나 이상의 필수 입력 필드가 누락된 경우 작업을 중단합니다.
                            // 필요에 따라 사용자에게 경고 메시지를 표시할 수 있습니다.
                            print("입력 필드 누락")
                            return
                        }
                        
                        if let editingMedicine = editingMedicine {
                            // 기존 약물을 업데이트
                            let updatedMedicine = Medicine(
                                id: editingMedicine.id,
                                name: medicineName,
                                capacity: capacity,
                                unit: mediCapacity[selectedMediIndex],
                                frequency: selectedDays,
                                alarms: alarmModel.alarms,
                                freOption: selectedOption,
                                sortedDays: sortedDaysString
                            )
                            medicineViewModel.updateMedicine(updatedMedicine)
                        } else {
                            // 새 약물을 추가
                            medicineViewModel.addMedicine(
                                name: medicineName,
                                capacity: capacity,
                                frequency: selectedDays,
                                unit: mediCapacity[selectedMediIndex],
                                alarms: alarmModel.alarms,
                                freOption: selectedOption,
                                sortedDays: sortedDaysString
                            )
                        }
                        //                        medicineViewModel.addMedicine(name: medicineName, capacity: capacity, frequency: selectedDays, unit: mediCapacity[selectedMediIndex], alarms: alarmModel.alarms, freOption: selectedOption, sortedDays: sortedDaysString)
                        //
                        
                        print(medicineViewModel.medicines)
                        print(alarmModel.alarms)
                        isActiveNext = true
                        
                        dismiss()
                    }, label: {
                        Text("저장")
                    })
                    .disabled(!isSaveButtonEnabled)
                    .foregroundStyle(isSaveButtonEnabled ? .blue : .gray)
                }
            }
        }
        .onAppear {
            isSaveButtonEnabled = !medicineName.isEmpty && !capacity.isEmpty
        }
        .onChange(of: medicineName) { _ in
            isSaveButtonEnabled = !medicineName.isEmpty && !capacity.isEmpty
        }
        .onChange(of: capacity) { _ in
            isSaveButtonEnabled = !medicineName.isEmpty && !capacity.isEmpty
        }
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
    
}

#Preview {
    //    AddMedicineView(isActiveNext: .constant(true))
    AddMedicineView(isActiveNext: .constant(true), editingMedicine: Medicine.sampleData.first)
}
