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
    case max5 = 5
    
    var minValue: Int { rawValue - 1 }
    var maxValue: Int { rawValue }
}
