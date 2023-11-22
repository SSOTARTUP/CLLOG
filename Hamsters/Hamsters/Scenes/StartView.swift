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
        TakensManager.shared.createEmptyTakens()
        let hm = HistoryModel(id: UUID(uuidString: "2ECC917E-5755-498D-8DE6-0F90C21B4FE4") ?? UUID(), capacity: "C", name: "NAME", settingTime: Date(), timeTaken: Date(), unit: "정")
        
        TakensManager.shared.check(date: Date(), historyModel: hm)
        
        let result = TakensManager.shared.fetch(date: Date())
        switch result {
        case .success(let histories):
            print(histories)
        case .failure(let error):
            print(error)
        }
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
