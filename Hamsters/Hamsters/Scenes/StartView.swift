//
//  ContentView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

struct StartView: View {
    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    
    init() {
//        DummyManager.shared.insertDayRecords()
//        DummyManager.shared.insertHistory()
//        guard let startDate = Calendar.current.date(byAdding: .day, value: -9, to: Date()) else { return }
//        guard let endDate = Calendar.current.date(byAdding: .day, value: 0, to: Date()) else { return }
//        var result = TakensManager.shared.fetchHistory(from: startDate, to: endDate)
//        print(result)
//      //  let result = DayRecordsManager.shared.fetchAllDayRecords()
//     //   print(result)
//        switch result {
//        case .success(let r):
//            print(r)
//            print(r.count)
//        case .failure(let e):
//            print(e)
//        }
        
    }
    
    var body: some View {
        ZStack {
            if setupComplete {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    StartView()
}
