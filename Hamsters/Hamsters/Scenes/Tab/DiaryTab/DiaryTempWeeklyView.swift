//
//  DiaryTempWeeklyView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/22/23.
//

import SwiftUI

struct DiaryTempWeeklyView: View {
    @StateObject private var calendarViewModel = DiaryCalendarViewModel()
    @State private var calendarHeight: CGFloat = 300.0
    @State private var showMonthly = false
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .thoNavy
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                DiaryWeeklyCalendar(calendarHeight: $calendarHeight)
                    .environmentObject(calendarViewModel)
                    .background(
                        Color.thoNavy
                            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    )
                    .frame(height: calendarHeight)

                Spacer()
                
                Text(calendarViewModel.selectedDate.basic)
                    .font(.title2)
                
                Spacer()
            }
            .navigationTitle(calendarViewModel.selectedDate.simple)
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
            .fullScreenCover(isPresented: $showMonthly) {
                DiaryExpandedCalendarView()
                    .environmentObject(calendarViewModel)
                    .onAppear {
                        calendarViewModel.openMonthly()
                    }
            }
        }
    }
}

#Preview {
    DiaryTempWeeklyView()
}
