//  CarPreviewScreen.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 31.01.2023.
//

import SwiftUI

/// Экран с превью открытого и закрытого автомобиля
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
        static let numberOfButtonsRange = 1..<5
    }

    // MARK: - Public properties

    var body: some View {
        backgroundStackView {
            VStack {
                headerView
                controllPanelView
                Spacer()
                    .frame(height: 40)
                if CarPreviewModel.tagSelected == 1 {
                    closeCarControllView
                }
                Spacer()
            }
        }
    }

    // MARK: - Private properties

    @StateObject private var CarPreviewModel = CarPreviewModelView()
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color(Constants.topGradientColorName), Color(Constants.bottomGradientColorName)], startPoint: .bottom, endPoint: .top)
    }

    private var controllPanelView: some View {
        HStack(spacing: 30) {
            ForEach(Constants.numberOfButtonsRange) { index in
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
                                .opacity(CarPreviewModel.tagSelected == index ? 1 : 0)
                        )
                }
                .onTapGesture {
                   withAnimation {
                        self.CarPreviewModel.tagSelected = index
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color(Constants.nBackgroundColorName)))
        .neumorfismUnselectedStyle()
        .offset(y: -30)
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
        Image(CarPreviewModel.isCarClosed ? Constants.closeCarImageName : Constants.carImageName)
            .resizable()
            .frame(height: 250)
            .padding(.leading, 30)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 1)
    }

    private var closeCarControllView: some View {
        Button {
            withAnimation {
                CarPreviewModel.openCloseCar()
            }
        } label: {
            HStack {
                Label {
                    Text(CarPreviewModel.isCarClosed ? Constants.closeText : Constants.openText)
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: CarPreviewModel.isCarClosed ? Constants.lockImageName : Constants.lockFillImageName)
                        .renderingMode(.template)
                        .foregroundColor(.gray)
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

    private var unlockView: some View {
        ZStack {
            LinearGradient(colors: !CarPreviewModel.isCarClosed ? [GlobalConstants.backgroundTopColor] : [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
            HStack {
                Text(CarPreviewModel.isCarClosed ? GlobalConstants.lockButtonImageName : GlobalConstants.unlockButtonText)
                    .frame(width: 70)
                    .padding(.trailing)
                ZStack {
                    Circle()
                        .fill(GlobalConstants.backgroundTopColor)
                        .shadow(color: .gray, radius: 3, x: -3, y: -3)
                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                        .frame(width: 45, height: 45)
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.CarPreviewModel.isCarClosed.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: GlobalConstants.lockButtonImageName)
                            .renderingMode(.template)
                            .foregroundColor(GlobalConstants.topLockGradient)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarPreviewScreen()
            .environment(\.colorScheme, .dark)
    }
}
