//
//  ContentView.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 31.01.2023.
//

import SwiftUI

/// Экран с урока
struct CarPreviewScreen: View {

    // MARK: - Private Constants

    private enum Constants {
        static let topGradientColorName = "TopGradient"
        static let bottomGradientColorName = "BottomGradient"
        static let nBackgroundColorName = "NBackground"
        static let teslaText = "Tesla"
        static let teslaDefaultRange = "187 km"
        static let closeCarImageName = "closeCar"
        static let carImageName = "car"
        static let closeText = "Закрыть"
        static let openText = "Открыть"
        static let lockImageName = "lock"
        static let lockFillImageName = "lock.fill"

    }

    // MARK: - Public constants

    var body: some View {
        backgroundStackView {
            VStack {
                headerView
                controllPanelView
                Spacer()
                    .frame(height: 40)
                if tagSelected == 1 {
                    closeCarControllView
                }
                Spacer()
            }
        }
    }

    // MARK: - Private properties

    @State private var isCarClosed = false
    @State private var tagSelected = 0

    private var gradient: LinearGradient {
        LinearGradient(colors: [Color(Constants.topGradientColorName), Color(Constants.bottomGradientColorName)], startPoint: .bottom, endPoint: .top)
    }

    private var controllPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                NavigationLink {
                    SettingsScreenView()
                } label: {
                    Image("\(index)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .neumorfismUnSelectedCircleStyle()
                        .overlay(
                            Circle()
                                .stroke(gradient, lineWidth: 2)
                                .opacity(tagSelected == index ? 1 : 0)
                        )
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color(Constants.nBackgroundColorName)))
        .neumorfismUnselectedStyle()
        .offset(y: -70)
    }

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constants.teslaText)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(Constants.teslaDefaultRange)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .opacity(0.4)
                carView
            }
            Spacer()
        }
        .padding()
    }

    private var carView: some View {
        Image(isCarClosed ? Constants.closeCarImageName : Constants.carImageName)
            .resizable()
            .frame(height: 250)
            .padding(.leading, 30)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 1)
    }

    private var closeCarControllView: some View {
        Button {
            withAnimation {
                isCarClosed.toggle()
            }
        } label: {
            HStack {
                Label {
                    Text(isCarClosed ? Constants.closeText : Constants.openText)
                } icon: {
                    Image(systemName: isCarClosed ? Constants.lockImageName : Constants.lockFillImageName)
                        .renderingMode(.template)
                        .neumorfismUnSelectedCircleStyle()
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color(Constants.nBackgroundColorName)))
            .neumorfismSelectedStyle()
        }
        .frame(width: 300)
    }

    // MARK: - Private methods

    private func backgroundStackView<Content: View> (content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(Constants.nBackgroundColorName))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct NeumorfismUnselected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: -5, y: -5)
            .shadow(color: Color(GlobalConstants.darkShadowColorName), radius: 5, x: 5, y: 5)
    }
}

struct NeumorfismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: 5, y: 5)
            .shadow(color: Color(GlobalConstants.darkShadowColorName), radius: 5, x: -5, y: -5)
    }
}

struct NeumorfismUnSelectedCircle: ViewModifier {

    private enum Constants {
        static let nBackgroundColorName = "NBackground"
    }

    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color(Constants.nBackgroundColorName)))
            .neumorfismUnselectedStyle()
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarPreviewScreen()
            .environment(\.colorScheme, .dark)
    }
}
