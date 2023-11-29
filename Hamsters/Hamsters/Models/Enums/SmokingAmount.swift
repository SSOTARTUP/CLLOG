//
//  SmokingAmount.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import Foundation

enum SmokingAmount: Int, CaseIterable {
    case min0 = 0
    case min1 = 1
    case min6 = 6
    case min11 = 11
    case min16 = 16
    case min21 = 21
    
    var minValue: Int { rawValue }
    var maxValue: Int { rawValue + 4 }
    
    var title: String {
        switch self {
        case .min0:
            "오늘은 흡연하지 않았어요!"
        case .min1:
            "1~5 개피"
        case .min6:
            "6~10 개피"
        case .min11:
            "11~15 개피"
        case .min16:
            "16~20 개피"
        case .min21:
            "1갑 초과"
        }
    }
}
