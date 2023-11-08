//
//  SmokingSatusView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

struct SmokingSetView: View {
    @Binding var pageNumber: Int
    @Binding var status: SmokingStatus?
    @State private var isActiveNext = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                OnboardingProgressBar(pageNumber: $pageNumber)
                
                Group {
                    Text("흡연중이신가요?")
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
            .onAppear {
                if status != nil {
                    isActiveNext = true
                }
            }
        }
    }
}

#Preview {
    SmokingSetView(pageNumber: .constant(4), status: .constant(.smoking))
}
