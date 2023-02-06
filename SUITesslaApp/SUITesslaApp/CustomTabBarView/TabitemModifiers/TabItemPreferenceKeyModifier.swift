//  TabItemPreferenceKeyModifier.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 04.02.2023.
//

import SwiftUI

/// Модификатор элемента стартового таббара
struct TabItemModifire: ViewModifier {

    // MARK: - Public Properties

    let tabBatItem: TabItem

    // MARK: - Pubcic Methods

    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBatItem])
    }
}

/// Модификатор элемента стартового таббара
struct TabItemImageModifire: ViewModifier {

    // MARK: - Public Properties

    var selection: Int
    let tabBarItem: Namespace.ID
    let index: Int

    // MARK: - Pubcic Methods

    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(.white)
            .foregroundColor(selection == index ? .black : .gray)
            .background(
                ZStack {
                    if selection == index {
                        Circle()
                            .fill(Color.topLockGradient)
                            .blur(radius: 10)
                            .opacity(0.4)
                            .frame(width: 45, height: 45)
                            .matchedGeometryEffect(
                                id: GlobalConstants.tabBarItemIdentifierText,
                                in: tabBarItem
                            )
                    }
                }
            )
    }
}
