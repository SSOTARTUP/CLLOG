//
//  ConditionViewModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/10/23.
//

import Foundation
import SwiftUI

class ConditionViewModel:ObservableObject {
    

    
    @Published var list:[Conditions] = []
    @Published var answer:ConditionAnswer = [:]
    
    
    init(){
        self.add()
    }
    
    func add(){
        guard let item = stack.popLast() else {
            print("All POP")
            return
        }
        
        switch item.sender {
        case .computer:
            if var last = list.last , last.first?.sender == .computer{
                last.append(item)
                list[list.count - 1] = last
            }else {
                list.append([item])
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.add()
            }
        default:
            list.append([item])
        }
        

    }
    
    var stack:Conditions = [
        ConditionModel(sender: .computer, text: "오늘도 기록하러 왔군요?"),
        ConditionModel(sender: .computer, text: "오늘도 파이팅해봐요! 햄!"),
        ConditionModel(sender: .computer, text: "업무나 공부와 같이 특정한 상황에서\n집중이 필요할 때,\n외부 자극 (소음, 대화, 전화 등)에 의해\n쉽게 방해를 받았나요?"),
        ConditionModel(sender: .user, conditionType: .concentration),
        ConditionModel(sender: .computer, text: "모터로 작동 하듯이,\n불필요하게 자주 움직였나요?"),
        ConditionModel(sender: .user, conditionType: .hyperactivity),
        ConditionModel(sender: .computer, text: "차분히 기다리는 것이 힘들거나,\n생각보다 행동이 앞 섰나요?"),
        ConditionModel(sender: .user, conditionType: .impulsivity),
        ConditionModel(sender: .computer, text: "마지막이에요! 햄!"),
        ConditionModel(sender: .computer, text: "일정을 세우거나 일의 우선 순위를\n정하기 어려웠나요?"),
        ConditionModel(sender: .user, conditionType: .taskPriority),
        ConditionModel(sender: .computer, text: "잘했어요!"),
        ConditionModel(sender: .computer, text: "다음 단계로 가볼까요! 햄!"),
        ConditionModel(sender: .button),

    ].reversed()
}

extension ConditionViewModel {
    typealias Conditions = [ConditionModel]
    typealias ConditionAnswer = [ConditionModel.ConditionType:Answer]
}
