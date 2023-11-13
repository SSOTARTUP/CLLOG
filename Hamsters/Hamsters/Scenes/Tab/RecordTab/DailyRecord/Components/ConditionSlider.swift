//
//  ConditionSlider.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI
import Sliders

struct ConditionSlider: View {
    let title: String
    @Binding var userValue: Double
    @State private var range = 0.0...4.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.body)
            
            ValueSlider(value: $userValue, in: range, step: 1.0)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        track:
                            HorizontalValueTrack(
                                view: Capsule()
                                        .foregroundStyle(.thoNavy)
                                        .padding(.horizontal, 4)
                            )
                            .background {
                                Capsule()
                                    .foregroundStyle(.thoDisabled)
                                    .padding(.horizontal, 4)
                            }
                            .frame(height: 12),
                        thumb:
                            Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0.0, y: 1.0)
                            .overlay{
                                Image("MyStatus"+String(Int(userValue)))
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.top, 6)
                                    .padding(.bottom, 10)
                            },
                        thumbSize: CGSize(width: 48, height: 48)
                    )
                )
                .frame(height: 56)
                .clipped()
            
            HStack {
                Text("전혀 아님")
                
                Spacer()
                
                Text("|")
                    .foregroundStyle(.secondary)

                Spacer()
                
                Text("중간")
                
                Spacer()
                
                Text("|")
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("매우 자주")
            }
            .font(.footnote)
            .foregroundStyle(.thoNavy)
            .padding(.horizontal, 6)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(15)
        
    }
}

#Preview {
    ConditionSlider(title: "집중하기 어려움", userValue: .constant(1.0))
}
