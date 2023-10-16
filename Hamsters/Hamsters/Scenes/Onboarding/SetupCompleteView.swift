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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                OnboardinProgressBar(pageNumber: $pageNumber)
                
                Image("HamsterV")
                    .resizable()
                    .scaledToFit()
                
                Text("설정 완료~~~!! ㅊㅋㅊㅋ")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
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
