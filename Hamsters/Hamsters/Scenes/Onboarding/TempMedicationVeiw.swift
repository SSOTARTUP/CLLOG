//
//  TempMedicationVeiw.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/16/23.
//

import SwiftUI

struct TempMedicationVeiw: View {
    @Binding var pageNumber: Int
    @State private var isActive = true
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                OnboardingProgressBar(pageNumber: $pageNumber)
                
                Text("투여하시는 약물이\n있나요?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 29)
                    .padding(.horizontal, 24)
                    
                Spacer()
                
                OnboardingNextButton(isActive: $isActive, pageNumber: $pageNumber)
                    .padding(.bottom, 30)
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
    TempMedicationVeiw(pageNumber: .constant(3))
}
