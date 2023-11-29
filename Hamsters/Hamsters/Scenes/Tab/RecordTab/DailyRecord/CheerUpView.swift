//
//  CheerUpView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/12/23.
//

import SwiftUI

struct CheerUpView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("HamsterV")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 100)
            
            Text("애니메이션 예정")
            
            Spacer()

            NextButton(title: "다음", isActive: .constant(true)) {
                viewModel.bottomButtonClicked()
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    CheerUpView(viewModel: DailyRecordViewModel())
}
