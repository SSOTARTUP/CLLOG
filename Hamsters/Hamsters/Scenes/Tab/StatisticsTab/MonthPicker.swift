//
//  MonthPicker.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/25/23.
//

import SwiftUI

struct MonthPicker: View {
    @State private var selectedYear = ""
    @State private var selectedMonth = ""
    @State private var selectedDate = Date()
    let months: [String] = Calendar.current.monthSymbols
    
    var yearRange: [String] {
        return Array(2000...2023).map{ String($0) }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $selectedYear) {
                    ForEach(yearRange, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Period Setting", selection: $selectedMonth) {
                    ForEach(months, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
        }
    }
}

#Preview {
    MonthPicker()
}
