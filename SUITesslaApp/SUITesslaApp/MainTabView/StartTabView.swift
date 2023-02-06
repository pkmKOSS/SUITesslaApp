//  StartTabView.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 06.02.2023.
//

import SwiftUI

/// Главный табвью
struct StartTabView: View {
    
    // MARK: - Public Properties
    
    var body: some View {
        CustomTabView(selection: $mainTabViewModel.selection) {
            StartScreenView()
                .myTabItem {
                    TabItem(
                        icon: "car"
                    )
                }
                .shadow(color: .gray, radius: mainTabViewModel.selection == 0 ? 0 : 10)
            ChargingView()
                .myTabItem {
                    TabItem(
                        icon:"bolt.fill"
                    )
                }
                .opacity(mainTabViewModel.selection == 1 ? 1 : 0)
            CarPreviewScreen()
                .myTabItem {
                    TabItem(
                        icon: "mappin.and.ellipse"
                    )
                }
                .opacity(mainTabViewModel.selection == 2 ? 1 : 0)
            Text("")
                .myTabItem {
                    TabItem(
                        icon: "person.fill"
                    )
                }
                .opacity(mainTabViewModel.selection == 3 ? 1 : 0)
        }
        .environment(\.colorScheme, .dark)
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Private Properties
    
    @StateObject private var mainTabViewModel = MainTabViewModel()
}
