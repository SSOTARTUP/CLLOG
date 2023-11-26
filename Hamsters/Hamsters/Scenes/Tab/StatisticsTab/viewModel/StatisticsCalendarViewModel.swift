//
//  StatisticsCalendarViewModel.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/27/23.
//

import SwiftUI

class StatisticsCalendarViewModel: ObservableObject {
    @Published var firstDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
    @Published var lastDate = Date()
    @Published var datesRange: [Date]?
}
