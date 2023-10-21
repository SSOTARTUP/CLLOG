//
//  DrinkAmount.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/21/23.
//

import Foundation

enum DrinkAmount: Int, CaseIterable {
    case min0 = 0
    case min1 = 1
    case min3 = 3
    case min5 = 5
    
    var minValue: Int { rawValue }
    var maxValue: Int { rawValue + 1 }
}
