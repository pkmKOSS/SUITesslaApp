//
//  SettingsScreenExtensions.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

/// Расширение представления для вызова соответствующих модификаторов
extension View {
    func settingsNeumorfismUnselectedStyle() -> some View {
        modifier(SettingsNeumorfismUnselected())
    }

    func settingsNeumorfismSelectedStyle() -> some View {
        modifier(SettingsNeumorfismSelected())
    }

    func settingsNeumorfismUnSelectedCircleStyle() -> some View {
        modifier(SettingsNeumorfismUnSelectedCircle())
    }

    func settingsNeumorfismSelectedCircleStyle() -> some View {
        modifier(SettingsNeumorfismSelectedCircle())
    }

    func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
        self.modifier(MeasureSizeModifier())
            .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }

    func myTabItem(_ label: () -> TabItem) -> some View {
        modifier(TabItemModifire(tabBatItem: label()))
    }
}
