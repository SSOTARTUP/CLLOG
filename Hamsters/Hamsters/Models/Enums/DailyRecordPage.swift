//
//  File.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/17/23.
//

import Foundation

enum DailyRecordPage: Int {
    case condition
    case mood
    case sleeping
    case sideEffect
    case weightCheck
    case menstruation
    case encourage
    case activity
    case smoking
    case caffein
    case drink
    case memo
    case complete
}

typealias DailyRecordPages = [DailyRecordPage]

extension DailyRecordPages {
    var convertPageToString: String {
        self.sorted{ $0.rawValue < $1.rawValue }
            .map { String($0.rawValue) }.joined(separator: "-")
    }
}
