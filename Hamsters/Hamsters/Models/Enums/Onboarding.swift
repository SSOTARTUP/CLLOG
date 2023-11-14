//
//  Onboarding.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/12/23.
//

import SwiftUI

enum Onboarding: Int {
    case welcome = 0
    case profile = 1
    case sex = 2
    case medication = 3
    case smoking = 4
    case complete = 5
    case end = 6

    var title: String? {
        switch self {
        case .profile:
            "안녕하세요! 반가워요 :)"
        case .sex:
            "성별을 선택해주세요"
        case .medication:
            "드시는 약물이 있나요?"
        case .smoking:
            "흡연중이신가요?"
        default:
            nil
        }
    }
    
    var subtitle: String? {
        switch self {
        case .medication:
            "Clue가 \(UserDefaults.standard.string(forKey: "username") ?? "이름없음")님을 더 잘 케어할 수 있어요!"
        default:
            nil
        }
    }
    
    var nextButtonTitle: String {
        switch self {
        case .welcome:
            "시작하기"
        case .complete:
            "완료"
        default:
            "다음"
        }
    }
    
    var topPadding: CGFloat {
        switch self {
        case .profile:
            20.0
        case .complete:
            80.0
        default:
            32.0
        }
    }
    
    var pageTotal: Double { 5.0 }
}
