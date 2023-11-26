//
//  DiaryCalendarViewModel.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/23/23.
//

import SwiftUI

class DiaryCalendarViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var tempDate: Date = Date()

    func openMonthly() {
        tempDate = selectedDate
    }
    
    func move() {
        selectedDate = tempDate
    }
    
}
