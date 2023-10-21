//
//  HamstersApp.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//

import SwiftUI

@main
struct HamstersApp: App {
    // 앱 전체에서 사용하기 위해 MedicineViewModel 인스턴스 생성
    @StateObject private var medicineViewModel = MedicineViewModel()

    var body: some Scene {
        WindowGroup {
            MedicationView()
                .environmentObject(medicineViewModel)

        }
    }
}
