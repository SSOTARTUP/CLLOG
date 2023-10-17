//
//  NicknameView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct NicknameSetView: View {
    @Binding var pageNumber: Int
    @Binding var nickname: String
    @State private var isActiveNext = false
    @State private var focusField = false
    @State private var characterLimitWarning = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                OnboardingProgressBar(pageNumber: $pageNumber)
                
                Group {
                    Text("닉네임을 알려주세요!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 29)
                    
                    Text("닉네임 입력")
                        .font(.subheadline)
                        .foregroundStyle(.thoNavy)
                        .opacity(focusField ? 1 : 0)
                        .padding(.bottom, 6)
                }
                .padding(.horizontal, 24)
                
                TextField("닉네임 입력", text: $nickname)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.vertical, 11)
                    .padding(.leading, 8)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        focusField = true
                    }
                    .onChange(of: nickname) { _ in
                        if nickname.count == 0 {
                            isActiveNext = false
                        } else {
                            isActiveNext = true
                        }

                        if nickname.count > 7 {
                            characterLimitWarning = true
                            nickname = String(nickname.prefix(7))
                        } else if nickname.count < 7 {
                            characterLimitWarning = false
                        }
                    }
                    .onSubmit {
                        focusField = false
                    }
                
                Text("한글, 영문, 특수 문자 사용 최대 7자로 입력해주세요!")
                    .font(.footnote)
                    .foregroundStyle(characterLimitWarning ? .red : .secondary)
                    .padding(.leading, 24)
                    .padding(.top, 6)

                Spacer()
                
                OnboardingNextButton(isActive: $isActiveNext, pageNumber: $pageNumber)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
            }
            .onTapGesture {
                hideKeyboard()
                focusField = false
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
    NicknameSetView(pageNumber: .constant(1), nickname: .constant("토리"))
}
