//
//  File.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/11/23.
//

import Foundation

struct ConditionModel: Identifiable, Equatable{
    var id = UUID()
    let sender: Sender
    var text: String?
    var conditionType: ConditionType?
    var answer: Answer?
    
    enum Sender {
        case computer
        case user
        case button
    }
    
    enum ConditionType: Int, CaseIterable {
        case concentration
        case hyperactivity
        case impulsivity
        case taskPriority
        
        var name: String {
            switch self {
            case .concentration: "주의력 조절"
            case .hyperactivity: "과잉행동 조절"
            case .impulsivity: "충동성 조절"
            case .taskPriority: "조직 및 시간관리"
            }
        }
    }
}
