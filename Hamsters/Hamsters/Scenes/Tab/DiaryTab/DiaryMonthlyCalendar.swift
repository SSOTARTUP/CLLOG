//
//  DiaryMonthlyCalendar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/22/23.
//

import SwiftUI
import FSCalendar

struct DiaryMonthlyCalendar: UIViewRepresentable {
    @Binding var selectedDate: Date
    @Binding var goToday: Bool
    @State private var isFirstLoad = true
    
    let sampleDate = ["2023-11-11", "2023-11-12", "2023-11-13", "2023-11-15", "2023-11-16", "2023-11-19", "2023-11-20", "2023-11-21", "2023-11-22"]

    func makeUIView(context: Context) -> FSCalendar {
        configureCalendar()
    }
    
    // 스유 -> 유킷
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.delegate = context.coordinator
        uiView.dataSource = context.coordinator
        
        // 해당 달 이후로 달력 생성 막기 위해
        if isFirstLoad {
            uiView.reloadData()
            isFirstLoad = false
        }
        
        // 오늘로 돌아가는 버튼 동작 위해
        if goToday {
            uiView.select(Date())
            selectedDate = Date()
            uiView.reloadData()
            goToday = false
        }
    }
    
    // 유킷 -> 스유
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedDate: $selectedDate, goToday: $goToday, isFirstLoad: $isFirstLoad, recordingDates: sampleDate)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        @Binding var selectedDate: Date
        @Binding var goToday: Bool
        @Binding var isFirstLoad: Bool
        let recordingDates: [String]
        
        init(selectedDate: Binding<Date>, goToday: Binding<Bool>, isFirstLoad: Binding<Bool>, recordingDates: [String]) {
            self._selectedDate = selectedDate
            self._goToday = goToday
            self._isFirstLoad = isFirstLoad
            self.recordingDates = recordingDates
        }

        func calendar(_ calendar: FSCalendar,
                      willDisplay cell: FSCalendarCell,
                      for date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            let eventScaleFactor: CGFloat = 1.2
            cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
            
            if date.basicDash == selectedDate.basicDash {
                let iconImage = UIImage(named: "HamsterFill")
                let backgroundView = UIImageView(image: iconImage)
                
                backgroundView.contentMode = .scaleAspectFit
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                
                cell.backgroundView = backgroundView
                
                NSLayoutConstraint.activate([
                    backgroundView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                    backgroundView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -8),
                    backgroundView.topAnchor.constraint(equalTo: cell.topAnchor, constant: -4)
                ])
            } else if date.basicDash == Date().basicDash {
                let iconImage = UIImage(named: "HamsterStroke")
                let backgroundView = UIImageView(image: iconImage)
                
                backgroundView.contentMode = .scaleAspectFit
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                
                cell.backgroundView = backgroundView
                
                NSLayoutConstraint.activate([
                    backgroundView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                    backgroundView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -8),
                    backgroundView.topAnchor.constraint(equalTo: cell.topAnchor, constant: -4)
                ])
            } else {
                cell.backgroundView = UIImageView(image: UIImage(named: ""))
            }
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
                      shouldSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) -> Bool {
            if date.basicDash > Date.now.basicDash {
                false
            } else {
                true
            }
        }
        
        func maximumDate(for calendar: FSCalendar) -> Date {
            Date()
        }
        
        func calendar(_ calendar: FSCalendar,
                      appearance: FSCalendarAppearance,
                      titleDefaultColorFor date: Date) -> UIColor? {
            if date.basicDash > Date.now.basicDash {
                UIColor.tertiaryLabel
            } else {
                UIColor.thoNavy
            }
        }
        
        func calendar(_ calendar: FSCalendar,
                      numberOfEventsFor date: Date) -> Int {
            if recordingDates.contains(date.basicDash) {
                return 1
            } else {
                return 0
            }
        }
        
        func calendar(_ calendar: FSCalendar,
                      appearance: FSCalendarAppearance,
                      eventOffsetFor date: Date) -> CGPoint {
            CGPoint(x: 14, y: -12)
        }
    }
}

extension DiaryMonthlyCalendar {
    func configureCalendar() -> FSCalendar {
        let calendar = FSCalendar()
        
        calendar.scope = .month
        calendar.firstWeekday = 2   // 월요일 시작
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollDirection = .vertical
        calendar.pagingEnabled = false
        
        // 상단부
        calendar.appearance.headerDateFormat = "M월"
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        calendar.appearance.headerTitleAlignment = .left
        calendar.appearance.headerTitleColor = .thoNavy
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerSeparatorColor = .clear
        calendar.appearance.headerTitleOffset = CGPoint(x: 0.0, y: 36.0)
        
        // 오늘 날짜 표시 지우기
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .white
        
        // 요일 표시 변경
        calendar.appearance.weekdayFont = UIFont.preferredFont(forTextStyle: .body)
        calendar.appearance.weekdayTextColor = .clear
        
        // 선택일 컬러 설정
        calendar.appearance.selectionColor = .clear
        calendar.appearance.titleSelectionColor = .white
        
        // 날짜 폰트 설정
        calendar.appearance.titleFont = UIFont.preferredFont(forTextStyle: .body)

        // 해당 달 외의 날짜 지우기
        calendar.placeholderType = .none
        
        calendar.select(selectedDate)
        calendar.setCurrentPage(selectedDate, animated: true)
        
        // 이벤트 서클 색상 설정
        calendar.appearance.eventDefaultColor = .thoDisabled
        calendar.appearance.eventSelectionColor = .thoGreen
        
        return calendar
    }
    
}
