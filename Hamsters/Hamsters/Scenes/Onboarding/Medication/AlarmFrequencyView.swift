//
//  AlarmFrequencyView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/17/23.
//

import SwiftUI

struct AlarmFrequencyView: View {
    enum Option: String, CaseIterable {
        case specificDay = "특정 요일에"
        case asNeeded = "필요할 때 투여"
    }
    
    @State private var selectedOption: Option? = nil
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ForEach(Array(zip(0..<Option.allCases.count, Option.allCases)), id: \.0) { index, option in
                
                if index > 0 {
                    Divider()
                }
                
                HStack {
                    Text("\(option.rawValue)")
                        .font(.body)
                    
                    Spacer()
                    
                    if selectedOption == option {
                        Image(systemName: "checkmark")
                            .font(.headline)
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.vertical, 14)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedOption = option
                }
            }
            .padding(.horizontal, 16)
            .background(.thoTextField)
            
        }
        .cornerRadius(10)
        .padding(.horizontal, 16)
        
        
        
    }
}

#Preview {
    AlarmFrequencyView()
}
