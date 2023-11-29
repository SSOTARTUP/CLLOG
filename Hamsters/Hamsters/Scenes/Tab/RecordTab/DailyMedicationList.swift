//
//  DailyMedicationList.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DailyMedicationList: View {
    @ObservedObject var viewModel: RecordMainViewModel
//    let medicineList = Medicine.sampleData
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
            
            if viewModel.medicineSchedule.isEmpty {
                Text("복용중인 약이 없습니다")
                    .foregroundStyle(.secondary)
                    .frame(height: 136)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 4) {
                        ForEach(viewModel.medicineSchedule, id: \.id) { schedule in
                            Button {
                                viewModel.takeMedicine(schedule)
                            } label: {
                                MedicationCheckItem(medicineInfo: schedule)
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

//struct MedicineSchedule {
//    let id: UUID
//    let capacity: String
//    let name: String
//    let unit: String
//    let settingTime: Date
//    
//    var timeTaken: Date?
//    var isTaken: Bool
//}

//struct HistoryModel: Codable {
//    let id: UUID
//    var capacity: String
//    var name: String
//    var settingTime: Date
//    var timeTaken: Date
//    var unit: String
//}

extension DailyMedicationList {
    struct MedicationCheckItem: View {
        let medicineInfo: MedicineSchedule

        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(medicineInfo.settingTime.shortTimeWithoutSecond)
                            .font(.footnote)
                    }
                    .foregroundStyle(medicineInfo.isTaken ? .thoGreen : .secondary)
                    
                    Spacer()
                    
                    Group {
                        Text(medicineInfo.name)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Text(medicineInfo.capacity + medicineInfo.unit)
                            .font(.footnote)
                    }
                    .foregroundStyle(medicineInfo.isTaken ? Color.white : .thoNavy)
                }
                
                Spacer()
            }
            .padding(12)
            .frame(width: 108, height: 136)
            .background(medicineInfo.isTaken ? .thoNavy : .thoDisabled)
            .cornerRadius(10)
        }
    }
}

#Preview {
    DailyMedicationList(viewModel: RecordMainViewModel())
}
