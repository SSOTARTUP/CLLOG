//
//  SelectedHamster.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/20/23.
//

import Foundation

enum selectedHam: String, CaseIterable {
    case gray
    case yellow
    case black
    
    var circleIamgeName: String {
        switch self {
        case .gray:
            "GrayCircleHam"
        case .yellow:
            "YellowCircleHam"
        case .black:
            "BlackCircleHam"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .gray:
            "GrayCircleHam_s"
        case .yellow:
            "YellowCircleHam_s"
        case .black:
            "BlackCircleHam_s"
        }
    }
}
