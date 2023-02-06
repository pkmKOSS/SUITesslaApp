//  CarCharchingViewModel.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 06.02.2023.
//

import SwiftUI

/// Вью модель экрана зарядки
final class ChargingViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var chargeSliderValue = 25.0
}
