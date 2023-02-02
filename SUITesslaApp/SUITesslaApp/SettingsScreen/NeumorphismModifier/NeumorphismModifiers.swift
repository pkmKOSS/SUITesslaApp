//
//  NeumorphismModifiers.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

/// Moдификатор для кнопки невыбранной кнопки настроек
struct SettingsNeumorfismUnselected: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: -5, y: -5)
            .shadow(color: Color(GlobalConstants.darkShadowColorName), radius: 5, x: 5, y: 5)
    }
}

/// Moдификатор для кнопки выбранной кнопки настроек
struct SettingsNeumorfismSelected: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: 5, y: 5)
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: -5, y: -5)
    }
}

/// Moдификатор для градиентного круга невыбранной кнопки настроек
struct SettingsNeumorfismUnSelectedCircle: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(
                Circle()
                    .stroke(LinearGradient(
                        colors: [.gray, .black],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                        style: StrokeStyle(lineWidth: 2)
                    )
            )
    }
}

/// Moдификатор для градиентного круга выбранной кнопки настроек
struct SettingsNeumorfismSelectedCircle: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(
                Circle()
                    .stroke(LinearGradient(
                        colors: [.black, .gray],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                        style: StrokeStyle(lineWidth: 2)
                    )
            )
    }
}
