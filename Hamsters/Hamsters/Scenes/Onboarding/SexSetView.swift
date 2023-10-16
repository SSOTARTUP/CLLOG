//
//  SelectSexView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

enum Sex {
    case female
    case male
    case menopause
}

struct SexSetView: View {
    @Binding var pageNumber: Int
    @State private var isActiveNext = false
    @State private var seletedSex: Sex?
    @State private var isMemopause = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                OnboardingProgressBar(pageNumber: $pageNumber)
                
                Group {
                    Text("성별을 선택해주세요")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 45)
                    
                    HStack(spacing: 13) {
                        Button {
                            seletedSex = .female
                            isActiveNext = true
                        } label: {
                            Text("여성")
                                .font(.headline)
                                .foregroundStyle(seletedSex == .female || seletedSex == .menopause ? .white : .thoNavy)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(seletedSex == .female || seletedSex == .menopause ? .thoNavy : .thoDisabled)
                                .cornerRadius(15)
                        }
                        
                        Button {
                            seletedSex = .male
                            isMemopause = false
                            isActiveNext = true
                        } label: {
                            Text("남성")
                                .font(.headline)
                                .foregroundStyle(seletedSex == .male ? .white : .thoNavy)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(seletedSex == .male ? .thoNavy : .thoDisabled)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                // 폐경 여부
                if seletedSex == .female || seletedSex == .menopause {
                    Button {
                        isMemopause.toggle()
                        if isMemopause {
                            seletedSex = .menopause
                        } else {
                            seletedSex = .female
                        }
                    } label: {
                        HStack {
                            Image(systemName: isMemopause ? "checkmark.circle.fill" : "circle")
                                .font(.title)
                                .foregroundStyle(isMemopause ? .thoNavy : Color.secondary)
                            
                            Text("페경 여부")
                                .font(.body)
                                .foregroundStyle(Color.primary)
                        }
                        .padding(.leading, 33)
                    }
                    .padding(.top, 22)
                }
                
                Spacer()
                
                OnboardingNextButton(isActive: $isActiveNext, pageNumber: $pageNumber)
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
    SexSetView(pageNumber: .constant(2))
}
