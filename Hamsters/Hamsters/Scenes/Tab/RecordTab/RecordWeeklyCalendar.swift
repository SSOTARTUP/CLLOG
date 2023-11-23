//
//  RecordWeeklyCalendar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/16/23.
//

import SwiftUI
import UIKit
import FSCalendar

struct WeeklyCalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date
    @Binding var calendarHeight: CGFloat
    @Binding var existLog: [String]
    @Binding var isToday: IsToday
    @State private var isFirstLoad = true
    
    func makeUIView(context: Context) -> FSCalendar {
        configureCalendar()
    }
    
    // 스유 -> 유킷
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.delegate = context.coordinator
        uiView.dataSource = context.coordinator
        
        if isFirstLoad {
            uiView.reloadData()
            isFirstLoad = false
        }
    }
    
    // 유킷 -> 스유
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedDate: $selectedDate, calendarHeight: $calendarHeight, existLog: $existLog, isToday: $isToday)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        @Binding var selectedDate: Date
        @Binding var calendarHeight: CGFloat
        @Binding var existLog: [String]
        @Binding var isToday: IsToday
        
        init(selectedDate: Binding<Date>, calendarHeight: Binding<CGFloat>, existLog: Binding<[String]>, isToday: Binding<IsToday>) {
            self._selectedDate = selectedDate
            self._calendarHeight = calendarHeight
            self._existLog = existLog
            self._isToday = isToday
        }
        
        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                selectedDate = date
                
                if date.basicDash > Date.now.basicDash {
                    isToday = .future
                } else if date.basicDash < Date.now.basicDash {
                    isToday = .past
                } else {
                    isToday = .today
                }
            }
        }
        
        func calendar(_ calendar: FSCalendar,
                      boundingRectWillChange bounds: CGRect,
                      animated: Bool) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                calendarHeight = bounds.height
            }
        }

        func calendar(_ calendar: FSCalendar,
                      willDisplay cell: FSCalendarCell,
                      for date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            var iconImage = UIImage()
            
            if self.existLog.contains(date.basicDash) {
                iconImage = UIImage(named: "SunflowerSeed")!
            } else {
                iconImage = UIImage(named: "SunflowerSeed")!.withTintColor(.thoDisabled)
            }
            
            let backgroundView = UIImageView(image: iconImage)
            backgroundView.contentMode = .scaleAspectFit
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.backgroundView = backgroundView
            
            NSLayoutConstraint.activate([
                backgroundView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                backgroundView.topAnchor.constraint(equalTo: cell.topAnchor)
            ])
        }
        
        func calendar(_ calendar: FSCalendar,
                      appearance: FSCalendarAppearance,
                      titleDefaultColorFor date: Date) -> UIColor? {
            UIColor.clear
        }
        
        func maximumDate(for calendar: FSCalendar) -> Date {
            Date()
        }
        
    }
}

extension WeeklyCalendarView {
    private func configureCalendar() -> FSCalendar {
        let calendar = FSCalendar()
        
        calendar.scope = .week
        calendar.firstWeekday = 2
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 상단부 삭제
        calendar.headerHeight = 0
        calendar.appearance.headerTitleColor = .clear
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // 오늘 날짜 표시 지우기
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .clear
        
        // 요일 표시 변경
        calendar.appearance.weekdayFont = UIFont.preferredFont(forTextStyle: .body)
        calendar.appearance.weekdayTextColor = .black
        
        // 선택일 컬러 설정
        calendar.appearance.selectionColor = .clear
        calendar.appearance.titleSelectionColor = .clear
        calendar.appearance.titleDefaultColor = .clear
        calendar.appearance.titleWeekendColor = .clear
        
        // 선택일을 오늘로
        calendar.select(Date())
        
        return calendar
    }
}

#Preview {
    WeeklyCalendarView(selectedDate: .constant(Date()), calendarHeight: .constant(300), existLog: .constant(["2023-11-16", "2023-11-15", "2023-11-13", "2023-11-11", "2023-11-9"]), isToday: .constant(.today))
        .border(.red)
}
