//
//  ConditionView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/10/23.
//

import SwiftUI


struct ConditionView: View {
    
    @StateObject var viewModel = ConditionViewModel()
    
    var body: some View {

        ScrollView {
            ForEach(Array(viewModel.list.enumerated()),id: \.self.offset) { (offset,element) in
                var _ = print(offset)
                if offset % 2 == 0{
                    ComputerChat(offset:offset, viewModel: viewModel)
                }else{
                    Text("user")
                }
            }
        }
        Button {
            viewModel.add()
        } label: {
            Text("POP}")
        }
    }
}

#Preview {
    ConditionView()
}
