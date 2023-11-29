//
//  CheerUpView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/12/23.
//

import SwiftUI

struct CheerUpView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    
    @AppStorage(UserDefaultsKey.hamsterImage.rawValue) private var storedHamster: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                switch selectedHam(rawValue: storedHamster)! {
                case .gray:
                    LottieConfettiView(filename: selectedHam(rawValue: storedHamster)!.CheerUpImageName)
                case .yellow:
                    LottieConfettiView(filename: selectedHam(rawValue: storedHamster)!.CheerUpImageName)
                case .black:
                    LottieConfettiView(filename: selectedHam(rawValue: storedHamster)!.CheerUpImageName)
                }
            }

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
