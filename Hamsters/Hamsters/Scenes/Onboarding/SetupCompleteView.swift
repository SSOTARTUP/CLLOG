//
//  SetupCompleteView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

// 임시 구현
struct SetupCompleteView: View {
    @Binding var pageNumber: Int
    @Binding var setupComplete: Bool
//    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    // 저장 확인용
//    @AppStorage(UserDefaultsKey.nickname.rawValue) private var storedNickname: String?
//    @AppStorage(UserDefaultsKey.sex.rawValue) private var storedSex: String?
//    @AppStorage(UserDefaultsKey.smoking.rawValue) private var storedSmoking: Bool?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                OnboardingProgressBar(pageNumber: $pageNumber)
                
                Spacer()
                

                ZStack {
                    VStack {
                        Image("HamsterV")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 124)
                            .padding(.bottom, 32)
                            
                        Text("준비 완료!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 12)
                        
                        Text("일상을 변화시킬 나를 위한 단서,\nClue가 도와줄게요!")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    
                    LottieConfettiView(filename: "onboardingConfetti")
                }
                
                Spacer()

                Button {
                    setupComplete = true
                    pageNumber += 1
                } label: {
                    Text("완료")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(.thoNavy)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    OnboardingBackButton(pageNumber: $pageNumber)
                }
            }
        }
    }
}

#Preview {
    SetupCompleteView(pageNumber: .constant(5), setupComplete: .constant(false))
}
