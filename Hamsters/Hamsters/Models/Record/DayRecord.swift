//
//  DayRecord.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/16/23.
//

import Foundation

struct DayRecord {
    var date: Date
    var id = UUID()
    var conditionValues: [Double]
    var moodValues: [Double]
    var sleepingTime: Int
    var popularEffect: [SideEffects.Major]
    var dangerEffect: [SideEffects.Dangerous]
    var weight: Double
    var amountOfSmoking: Int
    var amountOfCaffein: Int
    var isPeriod: Bool
    var amountOfAlcohol: Int
    var memo: String
}
