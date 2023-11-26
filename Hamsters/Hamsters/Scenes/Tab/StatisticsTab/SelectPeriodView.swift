//
//  SelectPeriodView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/25/23.
//

import SwiftUI

enum SelectPeriod: CaseIterable {
    case month
    case free
    
    var title: String {
        switch self {
        case .month:
            "월 선택"
        case .free:
            "기간 선택"
        }
    }
}

struct SelectPeriodView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: StatisticsCalendarViewModel
    
    @State var selectedSetting: SelectPeriod = .month
    
    @State private var calendarHeight: CGFloat = 400.0
    @State private var firstDate: Date?
    @State private var lastDate: Date?
    @State private var datesRange: [Date]?
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $selectedSetting) {
                    ForEach(SelectPeriod.allCases, id: \.self) {
                        Text($0.title)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                switch selectedSetting {
                case .month:
                    MonthPicker()
                case .free:
                    PeriodSelectCalendar(calendarHeight: $calendarHeight, firstDate: $firstDate, lastDate: $lastDate, datesRange: $datesRange)
                        .frame(height: calendarHeight)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                Button {
                    if let firstDate = firstDate {
                        viewModel.firstDate = firstDate
                    }
                    if let lastDate = lastDate {
                        viewModel.lastDate = lastDate
                    }
                    dismiss()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.thoNavy)
                        .frame(width: .infinity, height: 52)
                        .overlay {
                            Text("적용")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("기간 설정")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(Color.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    SelectPeriodView()
}
