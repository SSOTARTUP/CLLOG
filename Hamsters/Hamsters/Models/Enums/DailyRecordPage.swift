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
    
    var title: String {
        switch self {
        case .condition: "오늘의 컨디션"
        case .mood: "오늘의 기분"
        case .sleeping: "수면량"
        case .sideEffect: "오늘의 부작용"
        case .weightCheck: "체중"
        case .menstruation: "월경 여부"
        case .encourage: "격려"
        case .activity: "오늘의 운동량"
        case .smoking: "오늘의 흡연량"
        case .caffein: "오늘의 카페인"
        case .drink: "오늘의 음주량"
        case .memo: "메모"
        case .complete: "완료"
        }
    }
}

typealias DailyRecordPages = [DailyRecordPage]

extension DailyRecordPages {
    var convertPageToString: String {
        self.sorted{ $0.rawValue < $1.rawValue }
            .map { String($0.rawValue) }.joined(separator: "-")
    }
}
