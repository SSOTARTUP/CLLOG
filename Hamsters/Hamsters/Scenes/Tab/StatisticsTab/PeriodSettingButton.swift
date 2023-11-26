//
//  PeriodSettingButton.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/27/23.
//

import SwiftUI

// 임시 버튼
struct PeriodSettingButton: View {
    @StateObject private var viewModel = StatisticsCalendarViewModel()
    @State private var showCalendarSheet = false
    var body: some View {
        Button {
            showCalendarSheet.toggle()
        } label: {
            Text("\(viewModel.firstDate.basicShortYear) ~ \(viewModel.lastDate.basicShortYear)")
                .font(.callout)
                .foregroundStyle(.black)
                .padding(.vertical, 8)
                .frame(width: UIScreen.main.bounds.width - 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.yellow)
                        .frame(width: .infinity)
                        .overlay {
                            HStack {
                                Spacer()
                                
                                Image(systemName: "arrowtriangle.right.fill")
                                    .padding(.trailing, 8)
                            }
                        }
                )
        }
        .sheet(isPresented: $showCalendarSheet) {
            SelectPeriodView()
                .environmentObject(viewModel)
                .presentationDetents([.height(637)])
        }
    }
}

#Preview {
    PeriodSettingButton()
}
