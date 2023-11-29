//
//  DiaryMainView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/22/23.
//

import SwiftUI

struct DiaryMainView: View {
    @StateObject private var viewModel = DiaryMainViewModel()
    @State private var calendarHeight: CGFloat = 300.0
    @State private var showMonthly = false
    
//    init() {
//        setNavigationBar()
//    }
    
    var body: some View {
        NavigationStack {
            VStack {
                DiaryWeeklyCalendar(calendarHeight: $calendarHeight)
                    .background(
                        Color.thoNavy
                            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    )
                    .frame(height: calendarHeight)

                DiaryContentsView()
            }
            .navigationTitle(viewModel.selectedDate.simple)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showMonthly = true
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(.white)
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.thoNavy, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .fullScreenCover(isPresented: $showMonthly) {
                DiaryExpandedCalendarView()
                    .onAppear {
                        viewModel.openMonthly()
                    }
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    DiaryMainView()
}
