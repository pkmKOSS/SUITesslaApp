//  StartScreen.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 31.01.2023.
//

import SwiftUI

/// Стартовый экран приложения
struct StartScreenView: View {

    // MARK: - Private constants

    private enum Constants {
        static let backgroundColor: Color = .black
        static let backgroundTopColor: Color = Color("NBackground")
        static let bottomLockGradient: Color = Color("BottomGradient")
        static let topLockGradient: Color = Color("TopGradient")
        static let welcomeBackText = "Welcome back"
        static let settingsButtonImageName = "gearshape"
        static let lightCarImageName = "lightCar"
        static let darkCarImageName = "darkCar"
        static let unlockButtonText = "Unlock"
        static let lockButtonImageName = "lock"
    }

    // MARK: - Public properties

    var body: some View {
        NavigationView {
            ZStack {
                backgroundDarkGradientView()
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                contentsView
                settingsButtonView.offset(x: 150, y: -320)
            }
        }
    }

    // MARK: - Private properties

    @State private var isSystemUnlocked = false

    private var contentsView: some View {
        ZStack {
            if isSystemUnlocked {
                welcomeBackTextView
                    .offset(y: -200)
            }
            VStack {
                ZStack {
                    carImageGradientTransitionView
                        .padding()
                    unlockView
                        .offset(y: 220)
                        .padding()
                }
            }
        }
    }

    private var welcomeBackTextView: some View {
        Text(Constants.welcomeBackText)
            .font(.title)
            .bold()
    }

    private var settingsButtonView: some View {
        NavigationLink {
            CarPreviewScreen()
                .navigationBarBackButtonHidden(true)
        } label: {
            Image(systemName: Constants.settingsButtonImageName)
                .renderingMode(.template)
                .foregroundColor(.gray)
                .frame(width: 50, height: 50)
                .settingsNeumorfismUnSelectedCircleStyle()
        }
    }

    private var headSettingsButtonView: some View {
        HStack{
            Spacer()
            settingsButtonView
        }
    }

    private func backgroundDarkGradientView() -> some View {
        LinearGradient(
            colors: [
                isSystemUnlocked ? Constants.backgroundTopColor : Constants.backgroundColor,
                isSystemUnlocked ? Constants.backgroundTopColor : Constants.backgroundTopColor
            ],
            startPoint: .bottom, endPoint: .top
        )
    }

    private var carImageView: some View {
        Image(isSystemUnlocked ? Constants.lightCarImageName : Constants.darkCarImageName)
            .scaledToFit()
            .frame(height: 210)
            .offset(y: isSystemUnlocked ? 50 : 0)
            .padding()
    }

    private var carImageGradientTransitionView: some View {
        ZStack {
            if !isSystemUnlocked {
                LinearGradient(colors: [.black, Constants.backgroundTopColor], startPoint: .bottom, endPoint: .top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .offset(y: -120)
            }
            carImageView
        }
    }

    private var unlockView: some View {
        ZStack {
            LinearGradient(colors: !isSystemUnlocked ? [Constants.backgroundTopColor] : [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
            HStack {
                Text(isSystemUnlocked ? Constants.lockButtonImageName : Constants.unlockButtonText)
                    .frame(width: 70)
                    .padding(.trailing)
                ZStack {
                    Circle()
                        .fill(Constants.backgroundTopColor)
                        .shadow(color: .gray, radius: 3, x: -3, y: -3)
                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                        .frame(width: 45, height: 45)
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.isSystemUnlocked.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: Constants.lockButtonImageName)
                            .renderingMode(.template)
                            .foregroundColor(Constants.topLockGradient)
                            .frame(width: 32, height: 32)
                    }
                }
            }
            .padding()
        }
        .frame(width: 165, height: 79)
        .cornerRadius(35)
    }
}
