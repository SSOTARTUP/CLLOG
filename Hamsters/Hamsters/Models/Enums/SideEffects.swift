//
//  SideEffects.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import Foundation

enum SideEffects {
    enum Major: String, CaseIterable, Codable {
        case none = "없음"
        case insomnia = "불면증"
        case dizzy = "어지러움"
        case noAppetite = "식욕 감소"
        case headache = "두통"
        case stomachache = "복통"
        case sensitive = "신경과민"
        case cough = "기침"
        case stomachIssues = "위장장애"
        case hairLoss = "탈모"
        case itchy = "가려움"
        case rash = "발진"
        case jointPain = "관절통"
        case fever = "발열"
        case nauseous = "구역"
        case constipated = "변비"
        case mouthDry = "입마름"
    }
    
    enum Dangerous: String, CaseIterable, Codable {
        case none = "없음"
        case chestPain = "흉통"
        case shortnessOfBreath = "호흡곤란"
        case fainting = "실신"
        case hallucinations = "환각"
        case auditoryHallucinations = "환청"
        case suicidalThoughts = "자살충동"
        case anxiety = "불안"
        case restlessness = "초조"
        case mania = "조증"
        case fidgeting = "안절부절"
        case depression = "우울"  
    }
}


