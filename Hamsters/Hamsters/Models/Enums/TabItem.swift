//
//  TabItem.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

enum TabItem {
    case record
    case diary
    case statistics
    case my

    var textItem: Text {
        switch self {
        case .record: return Text("기록하기")
        case .diary: return Text("Diary")
        case .statistics: return Text("통계")
        case .my: return Text("내정보")
        }
    }

    var imageItem: Image {
        switch self {
        case .record: return Image(systemName: "square.and.pencil")
        case .diary: return Image(systemName: "book.closed.fill")
        case .statistics: return Image(systemName: "chart.xyaxis.line")
        case .my: return Image(systemName: "person.fill")
        }
    }
}
