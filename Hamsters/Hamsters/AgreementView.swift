//
//  AgreementView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

struct AgreementView: View {
    @Binding var pageNumber: Int
    @State private var isActiveNext = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 38) {
            // 로고 이미지 자리
            Rectangle()
                .frame(width: 100, height: 100)
                .padding(.leading)
                .foregroundColor(.gray)
                .padding(.top, 69)
            
            Group {
                InfoText()
                    .padding(.bottom, 6)
                
                AgreementCheck(isActiveNext: $isActiveNext)
                
                Spacer()
                
                OnboardingNextButton(isActive: $isActiveNext, pageNumber: $pageNumber)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct InfoText: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("새로운 시작을 위한\n첫 걸음")
                .font(.largeTitle)
                .fontWeight(.bold)
                .fixedSize()
            
            Text("복약기록 관리를 위해\n먼저 이용약관 제공에 동의해 주세요.")
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize()
        }
    }
}

struct AgreementCheck: View {
    @Binding var isActiveNext: Bool
    @State private var allAgree = false
    @State private var privacyAgree = false
    @State private var requiredAgree = false

    var body: some View {
        VStack(spacing: 10) {
            Button {
                allAgree.toggle()
                if allAgree {
                    privacyAgree = true
                    requiredAgree = true
                    isActiveNext = true
                } else {
                    privacyAgree = false
                    requiredAgree = false
                    isActiveNext = false
                }
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "checkmark")
                        .foregroundStyle(allAgree ? .white : .gray)
                    
                    Text("전체 동의")
                        .foregroundStyle(allAgree ? .white : .thoNavy)
                    
                    Spacer()
                }
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.leading, 24)
                .padding(.vertical, 27.5)
                .frame(maxWidth: .infinity)
                .background(allAgree ? .thoNavy : .thoDisabled)
                .cornerRadius(15)
                .padding(.bottom, 14)
            }
            
            Group {
                HStack(spacing: 16) {
                    Button {
                        privacyAgree.toggle()
                        if !privacyAgree {
                            allAgree = false
                            isActiveNext = false
                        }
                        if requiredAgree && privacyAgree {
                            allAgree = true
                            isActiveNext = true
                        }
                    } label: {
                        Image(systemName: privacyAgree ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundStyle(privacyAgree ? .thoNavy : .secondary)
                    }
                    
                    Text("개인 정보 처리 방침(필수)")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://www.apple.com/")!) {
                        Image(systemName: "chevron.forward")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                    }
                }
                
                HStack(spacing: 16) {
                    Button {
                        requiredAgree.toggle()
                        if !requiredAgree {
                            allAgree = false
                            isActiveNext = false
                        }
                        if requiredAgree && privacyAgree {
                            allAgree = true
                            isActiveNext = true
                        }
                    } label: {
                        Image(systemName: requiredAgree ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundStyle(requiredAgree ? .thoNavy : .secondary)
                    }
                    
                    Text("이용 약관 동의(필수)")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://www.apple.com/")!) {
                        Image(systemName: "chevron.forward")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                    }
                }
            }
            .padding(.horizontal, 18)
        }
    }
}

#Preview {
    AgreementView(pageNumber: .constant(0))
}
