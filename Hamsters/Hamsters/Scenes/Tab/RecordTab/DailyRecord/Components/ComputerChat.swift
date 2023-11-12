//
//  ComputerChat.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/11/23.
//

import SwiftUI

struct ComputerChat: View {
    
    var offset:Int
    @ObservedObject var viewModel:ConditionViewModel

    var body: some View {
        HStack(alignment:.top,spacing:0) {
            Image("chat_logo")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading,16)
                .padding(.trailing,8)
            
            VStack(alignment: .leading,spacing:0) {
                ForEach(viewModel.list[offset]) { item in
                    Text((item.text)!)
                        .font(.body)
                        .padding(10) // 8로 변경될 수 있음.
                        .background(.thoTextField)
                        .cornerRadius(4,corners:[.topLeft])
                        .cornerRadius(10,corners:[.topRight,.bottomLeft,.bottomRight])
                        .padding(.top,8)
                    if viewModel.list.count == 1 , viewModel.list[0].count == 1 {
                        Text("빠르게 넘기시려면 화면을 터치해주세요!")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading,8)
                            .padding(.top,4)
                    }
                }
            }
            .padding(.trailing,32)
            Spacer()
        }
        .padding(.top,20)
    }
}
