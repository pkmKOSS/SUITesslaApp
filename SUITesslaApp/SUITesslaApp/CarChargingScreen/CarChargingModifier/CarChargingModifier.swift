//
//  CarChargingModifier.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 06.02.2023.
//

import SwiftUI

struct CarChargingModifier: ViewModifier {

    // MARK: - Private properties

    private var carChargingViewModel: ChargingViewModel

    // MARK: - Init

    init(carChargingViewModel: ChargingViewModel) {
        self.carChargingViewModel = carChargingViewModel
    }

    // MARK: - Pubcic Methods

    func body(content: Content) -> some View {
        content
            .background(
                ChargeProgressViewShape()
                    .fill(
                        LinearGradient(
                            colors: [GlobalConstants.topLockGradient, GlobalConstants.bottomLockGradient],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .opacity(0.2)
                    .scaleEffect(
                        x: carChargingViewModel.chargeSliderValue / 100,
                        y: 3,
                        anchor: .leading
                    )
                    .blur(radius: 12)
                    .padding(.bottom, 20)
            )
    }
}
