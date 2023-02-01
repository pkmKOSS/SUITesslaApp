//
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
                backgroundDarkGradient()
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    HStack{
                        Spacer()
                        settingsButton
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 250, trailing: 40))

                    if isSystemUnlocked {
                        welcomeBackText
                    }
                    carImageView
                        .padding()
                    unlockView
                        .padding()
                }
            }
        }
    }

    // MARK: - Private properties

    @State private var isSystemUnlocked = false

    private var welcomeBackText: some View {
        Text(Constants.welcomeBackText)
            .font(.title)
            .bold()
    }

    private var settingsButton: some View {
        NavigationLink {
            CarPreviewScreen()
        } label: {
            ZStack {
                Constants.backgroundTopColor
                Image(systemName: Constants.settingsButtonImageName)
                    .foregroundColor(.gray)
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
        }
        .frame(width: 65, height: 65)
    }

    private func backgroundDarkGradient() -> some View {
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
            .frame(height: 200)
            .padding()
    }

    private var unlockView: some View {
        ZStack {
            Constants.backgroundTopColor
            HStack {
                Text(Constants.unlockButtonText).padding(.trailing)
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
