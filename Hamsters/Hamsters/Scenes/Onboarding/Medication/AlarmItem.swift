//
//  AlarmItem.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import Foundation

// 'AlarmItem'은 알람의 상세 정보를 담기 위한 데이터 모델입니다.
struct AlarmItem: Identifiable {
    var id = UUID() // 고유 식별자
    var date: Date  // 알람 시간
    var isEnabled: Bool = false // 알람 활성화 상태 (기본값은 true)
}

// MARK:- 빈도 설정을 위한
enum Day: String, CaseIterable, Identifiable, Comparable {
    
    case monday = "월"
    case tuesday = "화"
    case wednesday = "수"
    case thursday = "목"
    case friday = "금"
    case saturday = "토"
    case sunday = "일"
    
    var id: String { self.rawValue }
    
    // 비교하기 위해 순서 정의하기
    var order: Int {
        switch self {
        case .monday: return 1
        case .tuesday: return 2
        case .wednesday: return 3
        case .thursday: return 4
        case .friday: return 5
        case .saturday: return 6
        case .sunday: return 7
        }
    }
    
    // 비교를 위한 < 연산자 정의
    static func < (lhs: Day, rhs: Day) -> Bool {
        return lhs.order < rhs.order
    }
}

// 사용자의 알람 설정을 저장
struct PillReminder {
    var time: Date
    var frequency: Day
}
