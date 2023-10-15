//
//  AgreementView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

struct AgreementView: View {
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
                
                Button {
                    
                } label: {
                    NextButton(isActive: $isActiveNext)
                        .padding(.bottom, 30)
                }
                .disabled(isActiveNext ? false : true)
                
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
    @State private var requiredAgree = false
    @State private var optionalAgree = false
    
    var body: some View {
        VStack(spacing: 10) {
            Button {
                allAgree.toggle()
                if allAgree {
                    requiredAgree = true
                    optionalAgree = true
                    isActiveNext = true
                } else {
                    requiredAgree = false
                    optionalAgree = false
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
                        requiredAgree.toggle()
                        if requiredAgree {
                           isActiveNext = true
                        } else {
                            allAgree = false
                            isActiveNext = false
                        }
                        if requiredAgree && optionalAgree {
                            allAgree = true
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
                            .foregroundStyle(.secondary)
                            .foregroundStyle(.gray)
                    }
                }
                
                HStack(spacing: 16) {
                    Button {
                        optionalAgree.toggle()
                        if !optionalAgree {
                            allAgree = false
                        }
                        if requiredAgree && optionalAgree {
                            allAgree = true
                        }
                    } label: {
                        Image(systemName: optionalAgree ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundStyle(optionalAgree ? .thoNavy : .secondary)
                    }
                    
                    Text("선택 약관 동의")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://www.apple.com/")!) {
                        Image(systemName: "chevron.forward")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(.horizontal, 18)
        }
    }
}

#Preview {
    AgreementView()
}
