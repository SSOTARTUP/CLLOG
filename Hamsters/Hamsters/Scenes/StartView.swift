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
