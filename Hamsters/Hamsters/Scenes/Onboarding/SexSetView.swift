//
//  SelectSexView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/15/23.
//

import SwiftUI

struct SexSetView: View {
    @Binding var pageNumber: Int
    @Binding var selectedSex: SexClassification?
    @State private var isActiveNext = false
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
                            selectedSex = .female
                            isActiveNext = true
                        } label: {
                            Text("여성")
                                .font(.headline)
                                .foregroundStyle(selectedSex == .female || selectedSex == .menopause ? .white : .thoNavy)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(selectedSex == .female || selectedSex == .menopause ? .thoNavy : .thoDisabled)
                                .cornerRadius(15)
                        }
                        
                        Button {
                            selectedSex = .male
                            isMemopause = false
                            isActiveNext = true
                        } label: {
                            Text("남성")
                                .font(.headline)
                                .foregroundStyle(selectedSex == .male ? .white : .thoNavy)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(selectedSex == .male ? .thoNavy : .thoDisabled)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                // 폐경 여부
                if selectedSex == .female || selectedSex == .menopause {
                    Button {
                        isMemopause.toggle()
                        if isMemopause {
                            selectedSex = .menopause
                        } else {
                            selectedSex = .female
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
    SexSetView(pageNumber: .constant(2), selectedSex: .constant(.female))
}
