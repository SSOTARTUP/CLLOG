//
//  Date.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/12/23.
//

import Foundation

extension Date {
    var KST:Date {
        let date = Date(timeIntervalSince1970: self.timeIntervalSince1970)

        guard let koreanTimeZone = TimeZone(abbreviation: "KST") else {
            fatalError("Korean Time Zone not found")
        }

        return date.addingTimeInterval(TimeInterval(koreanTimeZone.secondsFromGMT(for: date)))
    }
    
    static func isTimeInPast(hour: Int, minute: Int) -> Bool {
        let calendar = Calendar.current
        let now = Date()

        var dateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        dateComponents.hour = hour
        dateComponents.minute = minute

        guard let specificTime = calendar.date(from: dateComponents) else {
            fatalError("Invalid date components")
        }

        return specificTime < now
    }
}

extension Date {
    // MARK: - 기본 & 짧은 날짜 표시
    public var basic: String {
        return toString("yyyy년 M월 d일")
    }
    
    public var basicShortYear: String {
        return toString("yy년 M월 d일")
    }
    
    public var basicDash: String {
        return toString("yyyy-MM-dd")
    }
    
    public var withWeek: String {
        return toString("yyyy년 M월 W주")
    }
    public var simple: String {
        return toString("yy년 M월")
    }
    public var monthAndDay: String {
        return toString("MM월 d일")
    }
    
    // MARK: - 요일 포함 날짜 표시
    public var basicWithDay: String {
        return toString("yyyy년 M월 d일 EEEEE")
    }
    
    private var weekOfDay: String {
        return toString("EEEEE")
    }
    
    // MARK: - 시간 표시
    public var timeWithoutSecond: String {
        return toString("a h시 m분")
    }
    public var timeWithSecond: String {
        return toString("a h시 m분 s초")
    }
    public var shortTimeWithoutSecond: String {
        return toString("HH:mm")
    }
    public var shortTimeWithSecond: String {
        return toString("HH:mm:ss")
    }
    
    // MARK: - 시간 포함 짧은 날짜 표시
    public var summaryWithTimeWithoutSecond: String {
        return toString("yyyy-MM-dd HH:mm")
    }
    public var summaryWithTimeWithSecond: String {
        return toString("yyyy-MM-dd HH:mm:ss")
    }
    
    // MARK: - 요일 & 시간 포함 기본 날짜 표시
    public var basicWithDayAndTimeWithoutSecond: String {
        return toString("yyyy년 M월 d일 (EEEEE) a h시 m분")
    }
    public var basicWithDayAndTimeWithSecond: String {
        return toString("yyyy년 M월 d일 (EEEEE) a h시 m분 s초")
    }
    
    // MARK: - Date -> String
    public func toString(_ dateFormat: String) -> String {
        return DateFormatter
            .convertToKoKR(dateFormat: dateFormat)
            .string(from: self)
    }
}

extension DateFormatter {
    public static func convertToKoKR(dateFormat: String) -> DateFormatter {
        let dateFormatter = createKoKRFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}

func createKoKRFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.timeZone = TimeZone(abbreviation: "KST")
    return dateFormatter
}
