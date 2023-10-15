//
//  NicknameView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct NicknameView: View {
    @Binding var pageNumber: Int
    @State private var nickname = ""
    @State private var isActiveNext = false
    @State private var focusField = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                OnboardinProgressBar(pageNumber: $pageNumber)
                    .padding(.bottom, 15)
                
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

                        if nickname.count > 5 {
                            nickname = String(nickname.prefix(5))
                        }
                    }
                    .onSubmit {
                        focusField = false
                    }

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
    NicknameView(pageNumber: .constant(1))
}
