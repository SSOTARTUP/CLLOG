//
//  UserDefaultsKey.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import Foundation

enum UserDefaultsKey: String {
    case nickname // 닉네임 - String
    case sex // 성별 - String(female, male, menopause)
    case smoking    // 흡연여부 - Bool
    case complete   // 설정 완료 - Bool
}
