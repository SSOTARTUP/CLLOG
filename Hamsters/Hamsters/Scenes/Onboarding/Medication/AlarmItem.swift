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
