//  CarPreviewModelView.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

/// Вью модель представления доступа к автомобилю
final class CarPreviewModelView: ObservableObject {

    // MARK: - Public properties

    @Published var isCarClosed = false
    @Published var tagSelected = 0

    // MARK: - Public methods

    func openCloseCar() {
        isCarClosed.toggle()
    }
}
