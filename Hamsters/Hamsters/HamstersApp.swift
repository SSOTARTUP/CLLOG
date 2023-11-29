//
//  HamstersApp.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/14/23.
//
//
//

import SwiftUI

@main
struct HamstersApp: App {
    var context = CoreDataManager.shared.persistentContainer.viewContext
    var body: some Scene {
        WindowGroup {
            StartView() .environment(\.managedObjectContext, context)
                .environmentObject(MedicineViewModel())
        }
    }
}
