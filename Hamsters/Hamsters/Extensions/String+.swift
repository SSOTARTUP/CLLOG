//
//  String+.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/17/23.
//

import SwiftUI

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension String {
    var convertStringToPage: [DailyRecordPage] {
        self.split(separator: "-")
            .compactMap { Int(String($0)) }
            .sorted{ $0 < $1 }
            .compactMap { DailyRecordPage(rawValue: $0) }
    }
}

extension String {
    public func toDate() -> Date? {
        let dateFormatter = createKoKRFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
