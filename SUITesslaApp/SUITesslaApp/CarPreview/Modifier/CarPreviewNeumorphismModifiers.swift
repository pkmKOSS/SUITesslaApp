//  NeumorphismModifiers.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

/// Moдификатор невыбранной кнопки
struct NeumorfismUnselected: ViewModifier {

    // MARK: - Public properties

    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: -5, y: -5)
            .shadow(color: Color(GlobalConstants.darkShadowColorName), radius: 5, x: 5, y: 5)
    }
}

/// Moдификатор выбранной кнопки
struct NeumorfismSelected: ViewModifier {

    // MARK: - Public properties

    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: 5, y: 5)
            .shadow(color: Color(GlobalConstants.darkShadowColorName), radius: 5, x: -5, y: -5)
    }
}

/// Moдификатор круга невыбранной кнопки
struct NeumorfismUnSelectedCircle: ViewModifier {

    // MARK: - Private constants

    private enum Constants {
        static let nBackgroundColorName = "NBackground"
    }

    // MARK: - Public properties

    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color(Constants.nBackgroundColorName)))
            .neumorfismUnselectedStyle()
    }
}

/// Методы для вызова модификаторов
extension View {
    func neumorfismUnselectedStyle() -> some View {
        modifier(NeumorfismUnselected())
    }

    func neumorfismSelectedStyle() -> some View {
        modifier(NeumorfismSelected())
    }

    func neumorfismUnSelectedCircleStyle() -> some View {
        modifier(NeumorfismUnSelectedCircle())
    }
}

