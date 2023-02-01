//
//  SUITesslaAppApp.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 31.01.2023.
//

import SwiftUI

@main
struct SUITesslaAppApp: App {
    var body: some Scene {
        WindowGroup {
            StartScreenView()
                .environment(\.colorScheme, .dark)
        }
    }
}
