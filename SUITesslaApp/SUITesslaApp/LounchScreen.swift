//
//  LounchScreen.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 05.02.2023.
//

import SwiftUI

/// Представление экрана загрузки
struct LounchScreen: View {

    // MARK: - Public properties

    @State private var isLounchingStarted = false

    var body: some View {
        backgroundStackView {
            ZStack {
                teslaHeaderLogoPathView.padding(.horizontal)
                teslaLogoPathView.padding(.horizontal)
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeIn(duration: 3)) {
                        isLounchingStarted = true
                    }
                }
            })
            .padding(.top, 200)
            .padding(.horizontal)
        }
    }

    // MARK: - Private properties

    private var teslaHeaderLogoPathView: some View {
         Path { path in
             path.move(to: CGPoint(x: 0, y: 33.29))
             path.addCurve(
                 to: CGPoint(x: 170, y: 0),
                 control1: CGPoint(x: 61.95, y: 8.64),
                 control2: CGPoint(x: 120.03, y: 0.19)
             )
             path.addCurve(
                 to: CGPoint(x: 340, y: 33.29),
                 control1: CGPoint(x: 219.97, y: 0.19),
                 control2: CGPoint(x: 277.95, y: 8.64)
             )
             path.addQuadCurve(
                 to: CGPoint(x: 330.43, y: 52.99),
                 control: CGPoint(x: 337.97, y: 39.31)
             )
             path.addCurve(
                 to: CGPoint(x: 170, y: 20.67),
                 control1: CGPoint(x: 273.8, y: 28.15),
                 control2: CGPoint(x: 218.42, y: 20.29)
             )
             path.addCurve(
                 to: CGPoint(x: 9.47, y: 52.99),
                 control1: CGPoint(x: 121.58, y: 20.29),
                 control2: CGPoint(x: 66.2, y: 28.24)
             )
             path.addQuadCurve(
                 to: CGPoint(x: 0, y: 33.39),
                 control: CGPoint(x: 2.8, y: 40.77)
             )
             path.closeSubpath()
         }
         .fill(
            isLounchingStarted ? Color(.white) : Color.blue
         )
         .scaleEffect(isLounchingStarted ? 1.0 : 0.0)
     }

    private var teslaLogoPathView: some View {
        Path {  path in
            path.move(to: CGPoint(x: 14.79, y: 62.12))
            path.addQuadCurve(
                to: CGPoint(x: 134.82, y: 33),
                control: CGPoint(x: 74.71, y: 34.26)
            )

            path.addLine(to: CGPoint(x: 169.81, y: 75.9))
            path.addLine(to: CGPoint(x: 204.89, y: 33))
            path.addQuadCurve(
                to: CGPoint(x: 324.92, y: 62.12),
                control: CGPoint(x: 265.1, y: 34.26)
            )

            path.addQuadCurve(
                to: CGPoint(x: 279.21, y: 99.67),
                control: CGPoint(x: 309.65, y: 85.32)
            )
            path.addCurve(
                to: CGPoint(x: 217.55, y: 71.34),
                control1: CGPoint(x: 277.18, y: 76.29),
                control2: CGPoint(x: 262.88, y: 71.34)
            )
            path.addLine(to: CGPoint(x: 170, y: 340))
            path.addLine(to: CGPoint(x: 121.87, y: 71.24))
            path.addCurve(
                to: CGPoint(x: 60.5, y: 96.67),
                control1: CGPoint(x: 76.83, y: 71.34),
                control2: CGPoint(x: 62.53, y: 76.29)
            )
            path.addQuadCurve(
                to: CGPoint(x: 14.79, y: 62.12),
                control: CGPoint(x: 30.15, y: 85.22)
            )
            path.closeSubpath()
        }
        .fill(
           isLounchingStarted ? Color(.white) : Color.blue
        )
        .opacity(isLounchingStarted ? 1.0 : 0.0)
    }

    var progress: CGFloat = 0.0

    private var logoConturView: some Shape {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 33.29))
            path.addCurve(
                to: CGPoint(x: 170, y: 0),
                control1: CGPoint(x: 61.95, y: 8.64),
                control2: CGPoint(x: 120.03, y: 0.19)
            )
            path.addCurve(
                to: CGPoint(x: 340, y: 33.29),
                control1: CGPoint(x: 219.97, y: 0.19),
                control2: CGPoint(x: 277.95, y: 8.64)
            )
            path.addQuadCurve(
                to: CGPoint(x: 330.43, y: 52.99),
                control: CGPoint(x: 337.97, y: 39.31)
            )
            path.addCurve(
                to: CGPoint(x: 170, y: 20.67),
                control1: CGPoint(x: 273.8, y: 28.15),
                control2: CGPoint(x: 218.42, y: 20.29)
            )
            path.addCurve(
                to: CGPoint(x: 9.47, y: 52.99),
                control1: CGPoint(x: 121.58, y: 20.29),
                control2: CGPoint(x: 66.2, y: 28.24)
            )
            path.addQuadCurve(
                to: CGPoint(x: 0, y: 33.39),
                control: CGPoint(x: 2.8, y: 40.77)
            )
            path.closeSubpath()
        }
    }

    // MARK: - Private methods


    private func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct LounchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LounchScreen()
            .environment(\.colorScheme, .dark)
    }
}
