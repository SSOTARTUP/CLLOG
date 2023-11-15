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
        let push: PushManager.Push = .init(pushType: .today, hour: 10, minute: 49, weekDays: [.wednesday,.tuesday,.monday])
    
        Task {
            let request = await PushManager.shared.requestNotification()
            print(request)
            let status = await PushManager.shared.noti(push)
            print(status)
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
