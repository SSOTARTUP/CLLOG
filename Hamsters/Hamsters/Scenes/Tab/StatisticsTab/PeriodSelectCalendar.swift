//
//  PeriodSelectCalendar.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/26/23.
//

import SwiftUI
import FSCalendar

struct PeriodSelectCalendar: UIViewRepresentable {
    @Binding var calendarHeight: CGFloat
    @Binding var firstDate: Date?
    @Binding var lastDate: Date?
    @Binding var datesRange: [Date]?
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.allowsSelection = true
        calendar.allowsMultipleSelection = true
        
        calendar.scope = .month
        calendar.firstWeekday = 2
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollDirection = .horizontal
        
        calendar.today = nil
        
        // 상단부
        calendar.appearance.headerDateFormat = "yyyy년 M월"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        calendar.headerHeight = 72
        
        calendar.appearance.weekdayTextColor = .secondaryLabel
        calendar.appearance.weekdayFont = UIFont.preferredFont(forTextStyle: .body)
        
        calendar.appearance.titleDefaultColor = .thoNavy

        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.delegate = context.coordinator
        uiView.dataSource = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(calendarHeight: $calendarHeight, firstDate: $firstDate, lastDate: $lastDate, datesRange: $datesRange)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        @Binding var calendarHeight: CGFloat
        @Binding var firstDate: Date?
        @Binding var lastDate: Date?
        @Binding var datesRange: [Date]?
        
        init(calendarHeight: Binding<CGFloat>, firstDate: Binding<Date?>, lastDate: Binding<Date?>, datesRange: Binding<[Date]?>) {
            self._calendarHeight = calendarHeight
            self._firstDate = firstDate
            self._lastDate = lastDate
            self._datesRange = datesRange
        }
        
        fileprivate let gregorian = Calendar(identifier: .gregorian)
        
        func calendar(_ calendar: FSCalendar,
                      cellFor date: Date,
                      at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
            return cell
        }
        
        func calendar(_ calendar: FSCalendar,
                      willDisplay cell: FSCalendarCell,
                      for date: Date,
                      at position: FSCalendarMonthPosition) {
            self.configure(calendar: calendar, cell: cell, for: date, at: position)
        }
        
        func calendar(_ calendar: FSCalendar,
                      boundingRectWillChange bounds: CGRect,
                      animated: Bool) {
            calendarHeight = bounds.height
        }

        
        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            if firstDate == nil {
                firstDate = date
                datesRange = [firstDate!]

                self.configureVisibleCells(calendar)
                return
            }
            
            // only first date is selected:
            if firstDate != nil && lastDate == nil {
                // handle the case of if the last date is less than the first date:
                if date <= firstDate! {
                    calendar.deselect(firstDate!)
                    firstDate = date
                    datesRange = [firstDate!]

                    self.configureVisibleCells(calendar)
                    return
                } else {
                    let range = datesRange(from: firstDate!, to: date)
                    
                    lastDate = range.last
                    
                    for d in range {
                        calendar.select(d)
                    }
                    
                    datesRange = range
                    self.configureVisibleCells(calendar)
                    
                    return
                }
            }
            
            // both are selected:
            if firstDate != nil && lastDate != nil {
                for d in calendar.selectedDates {
                    calendar.deselect(d)
                }
                firstDate = date
                calendar.select(firstDate)
                datesRange = [firstDate!]
                lastDate = nil

                self.configureVisibleCells(calendar)
                return
            }
        }
        
        func calendar(_ calendar: FSCalendar,
                      didDeselect date: Date) {
            
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            firstDate = nil
            lastDate = nil
            datesRange = []
            
            self.configureVisibleCells(calendar)
        }
        
        func maximumDate(for calendar: FSCalendar) -> Date {
            return Date()
        }
        
        func datesRange(from: Date, to: Date) -> [Date] {
            // in case of the "from" date is more than "to" date,
            // it should returns an empty array:
            
            if from > to {
                return [Date]()
            }
            
            var tempDate = from
            var array = [tempDate]
            
            while tempDate < to {
                tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
                array.append(tempDate)
            }
            
            return array
        }
        
        private func configureVisibleCells(_ calendar: FSCalendar) {
            calendar.visibleCells().forEach { (cell) in
                let date = calendar.date(for: cell)
                let position = calendar.monthPosition(for: cell)
                self.configure(calendar: calendar, cell: cell, for: date!, at: position)
            }
        }
        
        private func configure(calendar: FSCalendar, cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
            
            let diyCell = (cell as! DIYCalendarCell)
                
            var selectionType = SelectionType.none
            
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                
                if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                    selectionType = .middle
                }
                else if calendar.selectedDates.contains(previousDate) {
                    selectionType = .rightBorder
                }
                else if calendar.selectedDates.contains(nextDate) {
                    selectionType = .leftBorder
                }
                else {
                    selectionType = .single
                }
            } else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
        }
    }
}


