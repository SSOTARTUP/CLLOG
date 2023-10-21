//
//  SmokingStatus.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import Foundation

enum SmokingStatus {
    case smoking
    case nonSmoking
    
    var rawValue: Bool {
        switch self {
        case .smoking:
            return true
        case .nonSmoking:
            return false
        }
    }
}
