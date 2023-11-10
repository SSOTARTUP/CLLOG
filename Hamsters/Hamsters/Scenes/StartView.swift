//
//  ContentView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

struct StartView: View {
//    @AppStorage(UserDefaultsKey.complete.rawValue) private var setupComplete: Bool = false
    @State private var setupComplete = false
    
    
    var body: some View {
        ZStack {
            if setupComplete {
                MainTabView()
            } else {
                OnboardingView(setupComplete: $setupComplete)
            }
        }
    }
}

#Preview {
    StartView()
}
