//
//  StatisticsMainView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct StatisticsMainView: View {
    
    @StateObject var viewModel = StatisticsMainViewModel()
    
    var body: some View {
        ScrollView {
            Image("statisticsImage")
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea()
        .scrollIndicators(.never)
        .background(.thoTextField)
    }
}

#Preview {
    StatisticsMainView()
}
