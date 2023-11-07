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
//                            if let index = selectedEffect.firstIndex(of: effect) {
//                                self.selectedEffect.remove(at: index)
//                            } else {
//                                self.selectedEffect.append(effect)
//                            }
                            updateSelectedEffect(with: effect)  // 이 부분이 선택 항목을 업데이트하는 데 사용됩니다.

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
    
    private func updateSelectedEffect(with effect: SideEffects) {
           if let index = selectedEffect.firstIndex(of: effect) {
               // 이미 선택된 항목을 해제합니다.
               self.selectedEffect.remove(at: index)
           } else {
               // `.none` 항목이 선택되어 있을 경우 이를 제거합니다.
               if selectedEffect.contains(.none) {
                   selectedEffect.removeAll(where: { $0 == .none })
               }

               // 새로운 항목을 추가합니다.
               self.selectedEffect.append(effect)
           }
       }
    
}

#Preview {
    SideEffectCheckView(pageNumber: .constant(10), selectedEffect: .constant([.none]))
}
