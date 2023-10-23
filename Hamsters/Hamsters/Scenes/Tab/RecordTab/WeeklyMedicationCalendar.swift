//
//  WeeklyMedication.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct WeeklyMedicationCalendar: View {
    let weekDay = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        HStack {
            ForEach(weekDay, id: \.self) { symbol in
                if symbol == "화" {
                    DailyMedicationCalendar(dayOfWeek: symbol, today: true)
                } else {
                    DailyMedicationCalendar(dayOfWeek: symbol, today: false)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct DailyMedicationCalendar: View {
    let dayOfWeek: String
    let today: Bool
    var body: some View {
        VStack(spacing: 8) {
            Text(dayOfWeek)
                .font(.body)
            
            Image("SunflowerSeed")
                .renderingMode(dayOfWeek == "월" ? .original : .template)
                .resizable()
                .scaledToFit()
                .frame(width: 28)
                .foregroundStyle(Color(uiColor: .secondarySystemBackground))
        }
        .frame(width: 40, height: 80)
        .foregroundStyle(today ? .white : .primary)
        .background(today ? .thoNavy : .clear)
        .cornerRadius(20)
        
    }
}

extension WeeklyMedicationCalendar {
    static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
}

#Preview {
    WeeklyMedicationCalendar()
}
