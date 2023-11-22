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
        print(CoreDataManager.shared.fetchAllDayRecords())
        CoreDataManager.shared.createEmptyRecord()
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
