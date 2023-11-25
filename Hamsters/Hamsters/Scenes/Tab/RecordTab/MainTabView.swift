//
//  MainTabView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            RecordMainView()
                .tabItem {
                    TabItem.record.imageItem
                    TabItem.record.textItem
                }
            DiaryMainView()
                .tabItem {
                    TabItem.diary.imageItem
                    TabItem.diary.textItem
                }
            StatisticsMainView()
                .tabItem {
                    TabItem.statistics.imageItem
                    TabItem.statistics.textItem
                }
            MyInfoMainView()
                .tabItem {
                    TabItem.my.imageItem
                    TabItem.my.textItem
                }
        }
        .tint(.thoNavy)
    }
}

#Preview {
    MainTabView()
}
