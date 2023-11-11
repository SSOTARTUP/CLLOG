//
//  File.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/11/23.
//

import Foundation

struct ConditionModel :Identifiable ,Equatable{
    var id = UUID()
    let sender:Sender
    var text:String?
    var conditionType:ConditionType?
    var answer:Answer?
    
    enum Sender {
        case computer
        case user
        case button
    }
    
    enum ConditionType {
        case concentration
        case hyperactivity
        case impulsivity
        case taskPriority
    }
}
