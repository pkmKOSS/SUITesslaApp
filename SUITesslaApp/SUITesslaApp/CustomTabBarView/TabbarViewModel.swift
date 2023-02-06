//  TabbarViewModel.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 04.02.2023.
//

import SwiftUI

/// Модель стартового табвью
final class CustomTabViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var tabs: [TabItem] = []
}
