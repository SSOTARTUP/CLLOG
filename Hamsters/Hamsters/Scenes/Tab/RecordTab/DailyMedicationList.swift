//
//  DailyMedicationList.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DailyMedicationList: View {
    @ObservedObject var viewModel: RecordMainViewModel
    @State private var showMedicineEditSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 헤더
            HStack {
                Text("\(Image(systemName: "pill.fill")) 복용 체크")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.thoNavy)
                
                Spacer()
                
                Button {
                    showMedicineEditSheet.toggle()
                } label: {
                    Text("편집")
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
        .fullScreenCover(isPresented: $showMedicineEditSheet) {
            EditMedicineSheet()
        }
    }
}


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
                        
                        if medicineInfo.scheduleType == .specific {
                            Text(medicineInfo.settingTime.shortTimeWithoutSecond)
                                .font(.footnote)
                        } else if medicineInfo.scheduleType == .necessary {
                            Text("필요시")
                                .font(.footnote)
                        }
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
    
    struct EditMedicineSheet: View {
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            NavigationStack {
                EditMedicineView()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.thoNavy)
                            }
                        }
                    }
                    .navigationTitle("복용 약물 편집")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    DailyMedicationList(viewModel: RecordMainViewModel())
}
