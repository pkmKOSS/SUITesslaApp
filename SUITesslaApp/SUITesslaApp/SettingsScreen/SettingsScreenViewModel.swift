//
//  SettingsScreenViewModel.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 01.02.2023.
//

import SwiftUI

/// Вью модель экрана с настройками автомобиля
final class SettingsScreenViewModel: ObservableObject {

    // MARK: - Private constants

    private enum Constants {
        static let minDegress = 15.0
        static let maxdegrees = 31.0
        static let progressViewDeltaValue = 0.073
        static let defaultDegressDeltaValue = 1.0
    }

    // MARK: - Public properties

    @Published var currentMenuOffsetY: CGFloat = 0.0
    @Published var lastMenuOffsetY: CGFloat = 0.0
    @Published var acSliderValue: Float = 15.0
    @Published var fanSliderValue: Float = 15.0
    @Published var heatSliderValue: Float = 15.0
    @Published var autoSliderValue: Float = 15.0
    @Published var shadowRadius = 0.0
    @Published var completionAmout = 0.0
    @Published var selectedColor = Color.white
    @Published var temp = 15.0
    @Published var isSupportAlertShown = false
    @Published var isStepperStarted = false
    @Published var isSystemOn = false

    // MARK: - Public methods

    func setActionSheetPoint(maxHeight: CGFloat) {
        if -currentMenuOffsetY > maxHeight / 10 {
            currentMenuOffsetY = -180
        } else {
            currentMenuOffsetY = 0
        }
        lastMenuOffsetY = currentMenuOffsetY
    }

    func setCurrenActionSheertYOffset(size: CGSize) {
        currentMenuOffsetY = size.height + lastMenuOffsetY
    }

    func setTemp(temp: Double) {
        guard
            temp >= Constants.minDegress,
            temp < Constants.maxdegrees,
            temp > self.temp
        else {
            guard
                self.temp > Constants.minDegress,
                self.temp > temp
            else { return }
            withAnimation {
                self.temp = temp
                decrementStrokeCompletionAmount(value: Constants.progressViewDeltaValue)
                decrementStrokeShadowRadius(value: 1)
            }
            return
        }
            self.temp = temp
            incrementStrokeCompletionAmount(value: Constants.progressViewDeltaValue)
            incrementStrokeShadowRadius(value: 1.0)
    }

    func setTempWithStepper(temp: Double) {
        guard
            temp >= self.temp,
            temp >= Constants.minDegress,
            temp < Constants.maxdegrees
        else {
            guard
                self.temp > Constants.minDegress,
                self.temp > temp
            else { return }
            self.temp = temp
            decrementStrokeCompletionAmount(value: Constants.progressViewDeltaValue)
            decrementStrokeShadowRadius(value: Constants.defaultDegressDeltaValue)
            return
        }
        self.temp = temp
        incrementStrokeCompletionAmount(value: Constants.progressViewDeltaValue)
        incrementStrokeShadowRadius(value: Constants.defaultDegressDeltaValue)
    }

    func decrementStrokeShadowRadius(value: CGFloat) {
        self.shadowRadius -= Constants.defaultDegressDeltaValue
    }

    func incrementStrokeShadowRadius(value: CGFloat) {
        self.shadowRadius += Constants.defaultDegressDeltaValue
    }

    func decrementStrokeCompletionAmount(value: CGFloat) {
        self.completionAmout -= value
    }

    func incrementStrokeCompletionAmount(value: CGFloat) {
        self.completionAmout += value
    }

    func showSupprotAlert() {
        isSupportAlertShown.toggle()
    }

    func getURL(string: String, completion: (URL) -> ()) {
        guard let url = URL(string: string) else { return }
        completion(url)
    }

    func activateSystem() {
        isSystemOn.toggle()
    }
}
