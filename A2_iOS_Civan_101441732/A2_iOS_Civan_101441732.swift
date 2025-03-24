//
//  A2_iOS_Civan_Metin_101441732App.swift
//  A2_iOS_Civan_Metin_101441732
//
//  Created by Civan Metin on 2025-03-22.
//

import SwiftUI

@main
struct A2_iOS_Civan_Metin_101441732App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
