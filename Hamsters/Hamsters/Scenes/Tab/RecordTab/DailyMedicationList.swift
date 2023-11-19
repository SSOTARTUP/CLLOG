//
//  DailyMedicationList.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DailyMedicationList: View {
    let medicineList = Medicine.sampleData
//    let medicineList: [Medicine] = []
    @State private var isTaken: [Bool] = Array(repeating: false, count: Medicine.sampleData.count)
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 헤더
            HStack {
                Text("\(Image(systemName: "pill.fill")) 복용 체크")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.thoNavy)
                
                Spacer()
                
                Group {
                    Button {
                        
                    } label: {
                        Text("추가")
                    }
                    
                    
                    Divider()
                        .frame(height: 20)
                    
                    Button {
                        
                    } label: {
                        Text("수정")
                    }
                }
                .foregroundStyle(.secondary)
            }
            .padding(24)
            
            if medicineList.isEmpty {
                Text("복용중인 약이 없습니다")
                    .foregroundStyle(.secondary)
                    .frame(height: 136)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 4) {
                        ForEach(0..<medicineList.count, id: \.self) { index in
                            Button {
                                isTaken[index].toggle()
                            } label: {
                                MedicationCheckItem(isTaken: $isTaken[index], time: medicineList[index].alarms[0].date, name: medicineList[index].name, capacity: medicineList[index].capacity, unit: medicineList[index].unit)
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
                .padding(.leading, 24)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(width: screenBounds().width)
        .padding(.bottom, 40)
        .background(
            RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
                .foregroundStyle(.white)
        )
    }
}

extension DailyMedicationList {
    struct MedicationCheckItem: View {
        @Binding var isTaken: Bool
        
        let time: Date
        let name: String
        let capacity: String
        let unit: String
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(time.shortTimeWithoutSecond)
                            .font(.footnote)
                    }
                    .foregroundStyle(isTaken ? .thoGreen : .secondary)
                    
                    Spacer()
                    
                    Group {
                        Text(name)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Text(capacity + unit)
                            .font(.footnote)
                    }
                    .foregroundStyle(isTaken ? Color.white : .thoNavy)
                }
                
                Spacer()
            }
            .padding(12)
            .frame(width: 108, height: 136)
            .background(isTaken ? .thoNavy : .thoDisabled)
            .cornerRadius(10)
        }
    }
}

#Preview {
    DailyMedicationList()
}
