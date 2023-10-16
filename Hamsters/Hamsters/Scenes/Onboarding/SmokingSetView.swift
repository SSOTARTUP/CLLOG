//
//  SmokingSatusView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

enum SmokingStatus {
    case smoking
    case nonSmoking
}

struct SmokingSetView: View {
    @Binding var pageNumber: Int
    @State private var isActiveNext = false
    @State private var status: SmokingStatus?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                OnboardinProgressBar(pageNumber: $pageNumber)
                
                Group {
                    Text("성별을 선택해주세요")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 45)
                    
                    HStack(spacing: 13) {
                        Button {
                            status = .smoking
                            isActiveNext = true
                        } label: {
                            Text("흡연")
                                .font(.headline)
                                .foregroundStyle(status == .smoking ? .white : .thoNavy)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(status == .smoking ? .thoNavy : .thoDisabled)
                                .cornerRadius(15)
                        }
                        
                        Button {
                            status = .nonSmoking
                            isActiveNext = true
                        } label: {
                            Text("비흡연")
                                .font(.headline)
                                .foregroundStyle(status == .nonSmoking ? .white : .thoNavy)
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .background(status == .nonSmoking ? .thoNavy : .thoDisabled)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
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
    SmokingSetView(pageNumber: .constant(4))
}
