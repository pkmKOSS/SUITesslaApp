//
//  SUITesslaAppApp.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 31.01.2023.
//

import SwiftUI

@main
struct SUITesslaAppApp: App {
    @State var isLoadingComplete = false
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    LounchScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                isLoadingComplete = true
                            }
                        }
                    if isLoadingComplete {
                        StartTabView().transition(.slide)
                    }
                }
            }
            .environment(\.colorScheme, .dark)
        }
    }
}
