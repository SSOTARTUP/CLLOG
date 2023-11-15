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
