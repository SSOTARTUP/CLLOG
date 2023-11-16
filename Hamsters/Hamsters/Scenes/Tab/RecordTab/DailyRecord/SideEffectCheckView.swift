//
//  SideEffectCheckView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/22/23.
//

import SwiftUI
import WrappingHStack

struct SideEffectCheckView: View {
    @ObservedObject var dailyRecordViewModel = DailyRecordViewModel()
//    @Binding var pageNumber: Int
//    @Binding var popularEffect: [SideEffects.Major]
//    @Binding var dangerEffect: [SideEffects.Dangerous]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("불편한 증상이 있었나요?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("주요 부작용")
                            .font(.headline)
                            .foregroundStyle(.thoNavy)
                        
                        WrappingHStack(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 10) {
                            ForEach(SideEffects.Major.allCases, id: \.self) { effect in
                                CapsuleView(text: effect.rawValue, isSelected: dailyRecordViewModel.popularEffect.contains(effect)) {
                                    updatePopularEffect(with: effect)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 16)
                    .background(Color.thoTextField) // 박스의 배경 색상 설정
                    .cornerRadius(15) // 모서리를 둥글게 만듭니다
                    .padding(.bottom, 20)
                    
                    // 위험 부작용
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(.orange)
                            Text("위험 부작용")
                                .font(.headline)
                                .foregroundStyle(.thoNavy)
                        }
                        WrappingHStack(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 10) {
                            ForEach(SideEffects.Dangerous.allCases, id: \.self) { effect in
                                CapsuleView(text: effect.rawValue, isSelected: dailyRecordViewModel.dangerEffect.contains(effect)) {
                                    updateDangerEffect(with: effect)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 16)
                    .background(Color.thoTextField) // 박스의 배경 색상 설정
                    .cornerRadius(15) // 모서리를 둥글게 만듭니다
                    .padding(.bottom, 20)
                    
                    Text("위에 나열된 증상 중 해당사항이 없다면 메모란에 기록해주시고,\n다음 진단 때 꼭 담당 의료진에게 알려주시기 바랍니다.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 16)
                    
                    
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                NextButton(title: "다음", isActive: .constant(true)) {
                    dailyRecordViewModel.goToNextPage()
                }.disabled((dailyRecordViewModel.popularEffect.count < 1 && dailyRecordViewModel.dangerEffect.count < 1))
//                DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord:.constant(true), title: "다음")
//                    .disabled(popularEffect.count < 1 && dangerEffect.count < 1)
            }
        }
    }
    
    private func updatePopularEffect(with effect: SideEffects.Major) {
        if effect == .none {
            dailyRecordViewModel.popularEffect = [.none] // '없음'만 선택됨
        } else {
            dailyRecordViewModel.popularEffect.removeAll { $0 == .none } // '없음'을 제거
            if let index = dailyRecordViewModel.popularEffect.firstIndex(of: effect) {
                dailyRecordViewModel.popularEffect.remove(at: index)
            } else {
                dailyRecordViewModel.popularEffect.append(effect)
            }
        }
    }
    
    private func updateDangerEffect(with effect: SideEffects.Dangerous) {
        if effect == .none {
            dailyRecordViewModel.dangerEffect = [.none] // '없음'만 선택됨
        } else {
            dailyRecordViewModel.dangerEffect.removeAll { $0 == .none } // '없음'을 제거
            if let index = dailyRecordViewModel.dangerEffect.firstIndex(of: effect) {
                dailyRecordViewModel.dangerEffect.remove(at: index)
            } else {
                dailyRecordViewModel.dangerEffect.append(effect)
            }
        }
    }
}

#Preview {
    SideEffectCheckView(dailyRecordViewModel: DailyRecordViewModel())
}
