//
//  DailyMedicationList.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DailyMedicationList: View {
    let medicineList = Medicine.sampleData
    @State private var isTaken: [Bool] = Array(repeating: false, count: Medicine.sampleData.count)
    
    var body: some View {
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
                        
                        Text(dateFormatter.string(from: time))
                            .font(.footnote)
                    }
                    .foregroundStyle(isTaken ? .thoGreen : .secondary)
                    
                    Spacer()
                    
                    Group {
                        Text(name)
                            .font(.headline)
                        
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
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

#Preview {
    DailyMedicationList()
}
