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
    // 저장 확인용
    @AppStorage(UserDefaultsKey.nickname.rawValue) private var storedNickname: String?
    @AppStorage(UserDefaultsKey.sex.rawValue) private var storedSex: String?
    @AppStorage(UserDefaultsKey.smoking.rawValue) private var storedSmoking: Bool?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                OnboardingProgressBar(pageNumber: $pageNumber)
                
                Image("HamsterV")
                    .resizable()
                    .scaledToFit()
                
                Text("설정 확인")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("닉네임 : \(storedNickname ?? "저장 내용 없음")")
                
                Text("성별 : \(storedSex ?? "저장 내용 없음")")
                
                Text("흡연 여부 : \(storedSmoking?.description ?? "저장 내용 없음")")

                Button {
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
    SetupCompleteView(pageNumber: .constant(5))
}
