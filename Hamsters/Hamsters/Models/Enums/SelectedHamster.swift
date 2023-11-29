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
    
    var beforeRecordImageName: String {
        switch self {
        case .gray:
            "Main_Ham1_Before"
        case .yellow:
            "Main_Ham2_Before"
        case .black:
            "Main_Ham3_Before"
        }
    }
    
    var afterRecordImageName: String {
        switch self {
        case .gray:
            "Main_Ham1_After"
        case .yellow:
            "Main_Ham2_After"
        case .black:
            "Main_Ham3_After"
        }
    }
    
    var recordFinishImageName: String {
        switch self {
        case .gray:
            "RecordFin_Ham1"
        case .yellow:
            "RecordFin_Ham2"
        case .black:
            "RecordFin_Ham3"
        }
    }
    
    var CheerUpImageName: String {
        switch self {
        case .gray:
            "Middle_Ham1"
        case .yellow:
            "Middle_Ham2"
        case .black:
            "Middle_Ham3"
        }
    }

}
