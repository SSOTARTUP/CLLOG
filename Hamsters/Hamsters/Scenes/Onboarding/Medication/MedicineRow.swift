//
//  MedicineRow.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/19/23.
//

import SwiftUI

struct MedicineRow: View {
    var medicine: Medicine  // 이 뷰는 하나의 Medicine 객체를 받습니다.

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(medicine.name)  // Medicine 객체의 이름 속성을 사용합니다.
                    .font(.body)
                Text(medicine.fullCapacity)  // Medicine 객체의 용량 속성을 사용합니다.
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(medicine.sortedDays)
                .font(.body)
                .foregroundStyle(.thoNavy)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    MedicineRow(medicine: Medicine.init(name: "콘서타", capacity: "60", unit: "정", frequency: [.monday, .thursday], startTime: Date.now, alarms: [.init(date: Date.now)], sortedDays: "매일"))
}
