//
//  CustomStepper.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

/// Кастопный степер температуры
struct CustomStepper: View {

    // MARK: - Private constants

    private enum Constants {
        static let leftImageButtonName = "chevron.left"
        static let rightImageButtonName = "chevron.right"
        static let degreesDelta = 1.0
    }

    // MARK: - Public properties

    @Binding var isStarted: Bool
    @Binding var value: Double

    var body: some View {
        HStack {
            Button {
                value -= Constants.degreesDelta
            } label: {
                Image(systemName: Constants.leftImageButtonName)
            }
            Text("\(Int(value))°")
                .frame(width: 65)
                .font(.system(size: 34))
                .padding(.horizontal)
            Button {
                value += Constants.degreesDelta
            } label: {
                Image(systemName: Constants.rightImageButtonName)
            }
        }
        .foregroundColor(.white)
    }
}
