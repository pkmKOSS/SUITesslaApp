//  TabbarBackgroundView.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 04.02.2023.
//

import SwiftUI

/// Представления бэкграунда стартового табвью
struct CustomTabViewBackground: Shape {

    // MARK: - Public Methods

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 800))
        path.addLine(to: CGPoint(x: 18.00, y: 780.00))
        path.addCurve(
            to: CGPoint(x: 47.00, y: 765),
            control1: CGPoint(x: 25.00, y: 770.00),
            control2: CGPoint(x: 36.00, y: 766)
        )
        path.addLine(to: CGPoint(x: 125.00, y: 766))
        path.addCurve(
            to: CGPoint(x: 150, y: 772),
            control1: CGPoint(x: 135, y: 766),
            control2: CGPoint(x: 142.36, y: 768.62)
        )
        path.addLine(to: CGPoint(x: 171.00, y: 788.00))
        path.addCurve(
            to: CGPoint(x: 222.5, y: 788.00),
            control1: CGPoint(x: 186.15, y: 799.00),
            control2: CGPoint(x: 206.97, y: 799.00)
        )
        path.addLine(to: CGPoint(x: 244.00, y: 774.00))
        path.addCurve(
            to: CGPoint(x: 267.72, y: 766),
            control1: CGPoint(x: 250.64, y: 768.62),
            control2: CGPoint(x: 259.07, y: 766)
        )
        path.addLine(to: CGPoint(x: 345.97, y: 766))
        path.addCurve(
            to: CGPoint(x: 376.53, y: 778.94),
            control1: CGPoint(x: 357.51, y: 766),
            control2: CGPoint(x: 368.54, y: 770.67)
        )
        path.addLine(to: CGPoint(x: 393, y: 796))
        path.addLine(to: CGPoint(x: 393, y: 844))
        path.addLine(to: CGPoint(x: 0, y: 844))
        path.addLine(to: CGPoint(x: 0, y: 796))
        path.closeSubpath()
        return path
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
            .environment(\.colorScheme, .dark)
    }
}
