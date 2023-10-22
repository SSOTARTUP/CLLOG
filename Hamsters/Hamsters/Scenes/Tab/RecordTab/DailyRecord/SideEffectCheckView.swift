//
//  SideEffectCheckView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import SwiftUI
import WrappingHStack

struct SideEffectCheckView: View {
    @Binding var pageNumber: Int
    @State private var selectedEffect: [SideEffects] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("불편한 증상이 있었나요?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 16)
            
            WrappingHStack(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 10) {
                
                ForEach(SideEffects.allCases, id: \.self) { effect in
                    CapsuleView(text: effect.rawValue, isSelected: selectedEffect.contains(effect)) {
                        if let index = selectedEffect.firstIndex(of: effect) {
                            self.selectedEffect.remove(at: index)
                        } else {
                            self.selectedEffect.append(effect)
                        }
                    }
                }
            }
            .padding(.top, 20)
            
            DailyRecordNextButton(pageNumber: $pageNumber)
                .padding(.top, 90)
            
            
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SideEffectCheckView(pageNumber: .constant(10))
}
