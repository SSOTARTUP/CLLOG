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
}
