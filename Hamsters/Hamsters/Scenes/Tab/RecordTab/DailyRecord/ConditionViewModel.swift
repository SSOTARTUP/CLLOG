//
//  ConditionViewModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/10/23.
//

import Foundation

struct ConditionModel :Identifiable {
    var id = UUID()
    let sender:Sender
    var text:String?
    var val:Val?
    
    
    enum Sender {
        case computer
        case user
    }
    
    enum Val {
        case none
        case little
        case normal
        case lot
        case severe
    }
}
class ConditionViewModel:ObservableObject {
    
    typealias Conditions = [ConditionModel]
    
    @Published var list:[Conditions] = []

    func add(){
        guard let item = stack.popLast() else {
            print("All POP")
            return
        }
        
        print(item)
        switch item.sender {
        case .computer:
            if var last = list.last , last.first?.sender == .computer{
                last.append(item)
                list[list.count - 1] = last
            }else {
                list.append([item])
            }

        case .user:
            list.append([item])
        }
    }
    
    var stack:Conditions = [
        ConditionModel(sender: .computer, text: "오늘도 기록하러 왔군요?"),
        ConditionModel(sender: .computer, text: "오늘도 파이팅해봐요! 햄!"),
        ConditionModel(sender: .computer, text: "업무나 공부와 같이 특정한 상황에서 집중이 필요할 때,외부 자극 (소음, 대화, 전화 등)에 의해 쉽게 방해를 받았나요?"),
        ConditionModel(sender: .user),
        ConditionModel(sender: .computer, text: "업무나 공부와 같이 특정한 상황에서 집중이 필요할 때,외부 자극 (소음, 대화, 전화 등)에 의해 쉽게 방해를 받았나요?222"),
        
    ].reversed()
}
