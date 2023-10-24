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
    @Binding var selectedEffect: [SideEffects]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Group {
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
            }
            .padding(.horizontal, 16)

            Spacer()
            
            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord:.constant(true), title: "다음")
                .disabled(selectedEffect.count < 1)
        }
    }
}

#Preview {
    SideEffectCheckView(pageNumber: .constant(10), selectedEffect: .constant([.none]))
}
