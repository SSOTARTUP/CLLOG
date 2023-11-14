//
//  DrinkAmount.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import Foundation

enum DrinkAmount: Int, CaseIterable {
    case max0 = 0
    case max1 = 1
    case max2 = 2
    case max3 = 3
    
    var minValue: Int { rawValue - 1 }
    var maxValue: Int { rawValue }
    
    var title: String {
        switch self {
        case .max0:
            "오늘은 마시지 않았어요!"
        case .max1:
            "1병 미만"
        case .max2:
            "1~2병"
        case .max3:
            "2병 초과"
        }
    }
}
