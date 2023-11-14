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
        PushManager.shared.requestNotification()
    
        PushManager.shared.noti(pushType: .today, hour: 23, minute: 10) { status in
            switch status {
            case .success:
                print("success")
            case .authorizedFail:
                print("권한을 허용해 주세요.")
            case .error:
                print("푸시 에러 발생")
            }
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
