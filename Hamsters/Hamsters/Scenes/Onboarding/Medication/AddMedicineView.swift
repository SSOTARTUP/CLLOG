//
//  AddMedicineView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import SwiftUI

struct AddMedicineView: View {
    @StateObject private var alarmModel = AlarmViewModel()
    @State var medicineName = ""
    @State var capacity = ""
    @State var date = Date()
    @State private var selectedMediIndex: Int = 0

    
    let mediCapacity = ["정", "mg", "mcg", "mL", "g", "%"]
    let mediColumn = Array(repeating: GridItem(.flexible(), spacing: 6), count: 3)
    var mediFrequency = [String]()
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
//            alarmModel.alarms.append(AlarmItem(date: defaultAlarmTime))
            alarmModel.addAlarmTime(date: defaultAlarmTime)
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
                            .font(.body)
                            .padding(.vertical, 11)
                            .padding(.leading, 8)
                            .background(.thoTextField)
                            .cornerRadius(10)
                            .padding(.bottom, 28)
                        
                        
                        Text("용량")
                            .font(.headline)
                            .foregroundStyle(.thoNavy)
                            .padding(.leading, 8)
                            .padding(.bottom, 6)
                        TextField("용량 추가", text: $capacity)
                            .font(.body)
                            .padding(.vertical, 11)
                            .padding(.leading, 8)
                            .background(.thoTextField)
                            .cornerRadius(10)
                            .padding(.bottom, 18)
                        
                        LazyVGrid(columns: mediColumn) {
                            ForEach(0..<6) { index in
                                Button(action: {
                                    selectedMediIndex = index
                                }, label: {
                                    Text("\(mediCapacity[index])")
                                        .font(.body)
                                        .foregroundStyle(selectedMediIndex == index ? Color.white : Color.thoNavy) // 선택된 버튼은 다른 색상을 가집니다.
//                                        .foregroundStyle(isSelectedMedi ? .white : .thoNavy)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 15)
                                        .background(selectedMediIndex == index ? Color.thoNavy : Color.thoDisabled) // 선택된 버튼은 다른 배경을 가집니다.

//                                        .background(isSelectedMedi ? .thoNavy :.thoDisabled)
                                        .cornerRadius(13)
                                })
                                
                            }
                        }
                        .padding(.bottom, 48)
                        
                        
                        NavigationLink(destination: Text("s")) {
                            HStack {
                                Text("빈도")
                                    .foregroundStyle(.black)
                                
                                Spacer()
                                
                                Text("월요일")
                                    .foregroundStyle(.thoNavy)
                            }
                            .font(.body)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity)
                            .background(.thoTextField)
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
                        .background(Color.thoTextField)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
}

#Preview {
    AddMedicineView()
}
