//
//  DiaryWeeklyCalendar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/22/23.
//

import SwiftUI
import FSCalendar

struct DiaryWeeklyCalendar: UIViewRepresentable {
    @EnvironmentObject var viewModel: DiaryMainViewModel
    @Binding var calendarHeight: CGFloat
    
    func makeUIView(context: Context) -> FSCalendar {
        configureCalendar()
    }
    
    // 스유 -> 유킷
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.delegate = context.coordinator
        uiView.dataSource = context.coordinator
        
        uiView.reloadData()
        
        uiView.select(viewModel.selectedDate)
    }
    
    // 유킷 -> 스유
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedDate: $viewModel.selectedDate, calendarHeight: $calendarHeight)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        @Binding var selectedDate: Date
        @Binding var calendarHeight: CGFloat
        
        init(selectedDate: Binding<Date>, calendarHeight: Binding<CGFloat>) {
            self._selectedDate = selectedDate
            self._calendarHeight = calendarHeight
        }
        
        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                selectedDate = date
                calendar.reloadData()
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
                      shouldSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) -> Bool {
            if date.basicDash > Date.now.basicDash {
                false
            } else {
                true
            }
        }
        
        func calendar(_ calendar: FSCalendar,
                      appearance: FSCalendarAppearance,
                      titleDefaultColorFor date: Date) -> UIColor? {
            if date.basicDash > Date.now.basicDash {
                UIColor(white: 1, alpha: 0.3)
            } else {
                UIColor.white
            }
        }

        func calendar(_ calendar: FSCalendar,
                      willDisplay cell: FSCalendarCell,
                      for date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            
            if date.basicDash == selectedDate.basicDash {
                let iconImage = UIImage(named: "HamsterWeek")
                let backgroundView = UIImageView(image: iconImage)
                
                backgroundView.contentMode = .scaleAspectFit
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                
                cell.backgroundView = backgroundView
                
                NSLayoutConstraint.activate([
                    backgroundView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                    backgroundView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -12)
                ])
            } else {
                cell.backgroundView = nil
            }
        }

        func maximumDate(for calendar: FSCalendar) -> Date {
            Date()
        }
    }
}

extension DiaryWeeklyCalendar {
    func configureCalendar() -> FSCalendar {
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
        calendar.appearance.titleTodayColor = .white
        
        // 요일 표시 변경
        calendar.appearance.weekdayFont = UIFont.preferredFont(forTextStyle: .body)
        calendar.appearance.weekdayTextColor = .white
        
        // 선택일 컬러 설정
        calendar.appearance.selectionColor = .clear
        calendar.appearance.titleSelectionColor = .thoNavy
        
        
        // 날짜 폰트 설정
        calendar.appearance.titleFont = UIFont.preferredFont(forTextStyle: .body)
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .white
        
        calendar.select(viewModel.selectedDate)
        
        return calendar
    }
}
