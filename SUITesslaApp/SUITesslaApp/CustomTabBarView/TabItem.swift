//  TabItem.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 04.02.2023.
//

import Foundation

/// Элемент стартового табвью
struct TabItem: Identifiable, Equatable {
    
    /// Идентификатор элемента
    var id = UUID()
    
    /// Иконка элемента
    var icon: String
}
