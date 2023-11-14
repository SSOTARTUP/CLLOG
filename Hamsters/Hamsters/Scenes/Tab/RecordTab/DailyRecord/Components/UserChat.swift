//
//  UserChat.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/11/23.
//

import SwiftUI

struct UserChat: View {
    
    @ObservedObject var viewModel:ConditionViewModel
    let conditionModel:ConditionModel?
    
    var body: some View {
        HStack {
            Button {
                answerButtonClicked(answer: .none)
            } label: {
                VStack(spacing:0) {
                    if let type = conditionModel?.conditionType, viewModel.answer[type] == Answer.none {
                        Image("MyStatus0")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }else {
                        Image("MyStatus0_d")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }

                    Text("없음")
                        .foregroundColor(.secondary)
                        .padding(.top,8)
                }
            }
            Spacer()
            Button {
                answerButtonClicked(answer: .little)
            } label: {
                VStack(spacing:0) {
                    if let type = conditionModel?.conditionType, viewModel.answer[type] == Answer.little {
                        Image("MyStatus1")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }else {
                        Image("MyStatus1_d")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }
                    Text("조금")
                        .foregroundColor(.secondary)
                        .padding(.top,8)
                }
            }
            Spacer()
            Button {
                answerButtonClicked(answer: .normal)
            } label: {
                VStack(spacing:0) {
                    if let type = conditionModel?.conditionType, viewModel.answer[type] == Answer.normal {
                        Image("MyStatus2")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }else {
                        Image("MyStatus2_d")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }
                    Text("보통")
                        .foregroundColor(.secondary)
                        .padding(.top,8)
                }
            }
            Spacer()
            Button {
                answerButtonClicked(answer: .lot)
            } label: {
                VStack(spacing:0) {
                    if let type = conditionModel?.conditionType, viewModel.answer[type] == Answer.lot {
                        Image("MyStatus3")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }else {
                        Image("MyStatus3_d")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }
                    Text("많이")
                        .foregroundColor(.secondary)
                        .padding(.top,8)
                }
            }
            Spacer()
            Button {
                answerButtonClicked(answer: .severe)
            } label: {
                VStack(spacing:0) {
                    if let type = conditionModel?.conditionType, viewModel.answer[type] == Answer.severe {
                        Image("MyStatus4")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }else {
                        Image("MyStatus4_d")
                            .resizable()
                            .frame(width: 50, height: 42)
                    }
                    Text("심함")
                        .foregroundColor(.secondary)
                        .padding(.top,8)
                }
            }
        }
        .padding(8)
        .padding(.top,4)
        .background(.thoDisabled)
        .cornerRadius(2,corners:[.bottomRight])
        .cornerRadius(10,corners:[.topRight,.bottomLeft,.topLeft])
        .padding(.leading,48)
        .padding(.trailing,16)
        .padding(.top,20)
    }
}


extension UserChat{
    func answerButtonClicked(answer:Answer){
        guard let type = conditionModel?.conditionType else { return }
        if viewModel.answer[type] == nil {
            viewModel.answer[type] = answer
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                viewModel.add()
            }
        } else {
            viewModel.answer[type] = answer
        }
    }
}

#Preview {
    UserChat(viewModel: ConditionViewModel(),conditionModel: ConditionModel(sender: .user))
}
