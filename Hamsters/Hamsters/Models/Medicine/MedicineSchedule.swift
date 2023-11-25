//
//  MedicineSchedule.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/23/23.
//

import Foundation

struct MedicineSchedule {
    let id: UUID
    let capacity: String
    let name: String
    let unit: String
    let settingTime: Date
    
    var timeTaken: Date?
    var isTaken: Bool
}
