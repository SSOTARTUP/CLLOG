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
            
            List {
                ForEach(Option.allCases, id: \.self) { option in
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
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedOption = option
                    }
                }
            }
            
            
        }
        
        
        
    }
}

#Preview {
    AlarmFrequencyView()
}
