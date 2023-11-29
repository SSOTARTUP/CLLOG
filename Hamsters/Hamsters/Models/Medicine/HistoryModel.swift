//
//  TakenModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/23/23.
//

import Foundation

struct HistoryModel: Codable,Identifiable {
    let id: UUID
    var capacity: String
    var name: String
    var settingTime: Date
    var timeTaken: Date
    var unit: String
}
