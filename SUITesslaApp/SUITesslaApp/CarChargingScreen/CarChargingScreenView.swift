//  CarCharchingScreenView.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 06.02.2023.
//

import SwiftUI

/// Экран зарядки батареи
struct ChargingView: View {

    // MARK: - Public Methods

    var body: some View {
        contentView
    }

    // MARK: - Private Properties

    @StateObject private var chargingViewModel = ChargingViewModel()

    private var contentView: some View {
        backgroundStackView {
            VStack {
                headBarView
                carPreviewImageView
                Spacer(minLength: 117)
                VStack(spacing: 12) {
                    progressView
                    chargeProgressTextView
                    chargeLimitView
                }
                chargeDisclosureView
            }
        }
    }

    private var progressView: some View {
        VStack {
            progressTextView
            ZStack {
                defaultProgressView
                currentProgressView
            }
        }
        .frame(width: 275, height: 80)
    }

    private var currentProgressView: some View {
        ChargeProgressViewShape()
            .fill(
                LinearGradient(
                    colors: [
                        GlobalConstants.topLockGradient,
                        GlobalConstants.bottomLockGradient
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .scaleEffect(
                x: chargingViewModel.chargeSliderValue / 100,
                y: 1,
                anchor: .leading
            )
            .background(
                ChargeProgressViewShape()
                    .fill(
                        LinearGradient(
                            colors: [
                                .gray,
                                GlobalConstants.backgroundTopColor
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .opacity(1)
                    .scaleEffect(
                        x: 1,
                        y: 1,
                        anchor: .leading
                    )
            )
            .padding(.bottom, 190)
    }

    private var defaultProgressView: some View {
        ChargeProgressViewShape()
            .fill(
                Color.red
            )
            .opacity(0.3)
            .blur(radius: 1)
            .scaleEffect(y: 2, anchor: .bottom)
            .padding(.bottom, 240)
            .padding(.trailing, 119)
    }

    private var progressTextView: some View {
        HStack(spacing: 5) {
            Text("\(Int(chargingViewModel.chargeSliderValue))")
                .font(.system(size: 35, weight: .semibold))
            Text(GlobalConstants.percentText)
                .padding(.top, 10)
                .foregroundColor(.white)
        }
    }

    private var chargeDisclosureView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(GlobalConstants.backgroundTopColor)
                .overlay(
                    externalDisclosureGroupRoundedRectangle
                        .overlay(internalDisclosureGroupRoundedRectangle)
                        .frame(width: 338, height: 130)
                )
            disclosureGroupContentView
        }
        .offset(y: -50)
    }

    private var externalDisclosureGroupRoundedRectangle: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.white.opacity(0.2), lineWidth: 4)
            .blur(radius: 4)
            .offset(x: 2, y: 2)
            .mask(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            colors: [.black, .clear],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
            )
    }

    private var internalDisclosureGroupRoundedRectangle: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.black.opacity(0.7), lineWidth: 4)
            .blur(radius: 4)
            .offset(x: -2, y: -2)
            .mask(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            colors: [.black, .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
    }

    private var disclosureGroupContentView: some View {
        HStack {
            Text(GlobalConstants.nearbySuperchargersText)
                .font(.system(size: 20))
                .foregroundColor(.white)
            Button {} label: {
                Image(systemName: GlobalConstants.chevronDownImageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
            }
        }
    }

    private var chargeProgressTextView: some View {
        HStack(spacing: 25) {
            VStack {
                Rectangle()
                    .foregroundColor(.gradientTopColor)
                    .frame(width: 2, height: 9)
                    .padding(.leading, 31)
                Text(GlobalConstants.seventhyFivePercentText)
            }
            .padding(.leading, 100)
            VStack {
                Rectangle()
                    .foregroundColor(.gradientTopColor)
                    .frame(width: 2, height: 9)
                    .padding(.leading, 31)
                Text(GlobalConstants.oneHundredPersentText)
            }
        }
        .padding(.leading, 80)
        .offset(y: -50)
    }

    private var chargeLimitView: some View {
        VStack {
            ChargingliderView(sliderValue: $chargingViewModel.chargeSliderValue)
                .frame(height: 9)
                .frame(width: 275)
            Text(GlobalConstants.chargeLimitText)
                .foregroundColor(.gray)
        }
        .offset(y: -50)
    }

    private var carPreviewImageView: some View {
        Image(GlobalConstants.carImageName)
            .resizable()
            .scaledToFill()
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.bottom, 40)
    }

    private var settingsView: some View {
        ZStack {
            goPreviusShadowCircle
            settingsButtonView
        }
    }

    private var climateTextView: some View {
        Text(GlobalConstants.climateTextViewText)
            .padding()
            .foregroundColor(.white)
    }

    private var headBarView: some View {
        HStack {
            goPreviusScreenButtonView
            climateTextView
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
            settingsView
        }
    }

    private var goPreviusShadowCircle: some View {
        Circle()
            .fill(GlobalConstants.backgroundTopColor)
            .shadow(color: .gray, radius: 5, x: -3, y: -3)
            .shadow(color: .black, radius: 5, x: 5, y: 5)
            .frame(width: 73, height: 73)
    }

    private var goPreviusScreenButton: some View {
        Button {

        } label: {
            Image(systemName: GlobalConstants.goPreviusButtonImageName)
                .renderingMode(.template)
                .foregroundColor(.gray)
                .frame(width: 50, height: 50)
                .settingsNeumorfismUnSelectedCircleStyle()
        }
    }

    private var goPreviusScreenButtonView: some View {
        ZStack {
            goPreviusShadowCircle
            goPreviusScreenButton
        }
    }

    private var settingsButtonView: some View {
        Button {} label: {
            Image(systemName: GlobalConstants.settingsGearshapeImageName)
                .renderingMode(.template)
                .foregroundColor(.gray)
                .frame(width: 50, height: 50)
                .settingsNeumorfismUnSelectedCircleStyle()
        }
    }

    private var screenNameTextView: some View {
        Text(GlobalConstants.chargingScreenNameText)
            .font(.system(size: 20, weight: .semibold))
    }
}

// MARK: - Private Methods
private func backgroundStackView<Content: View>(content: () -> Content) -> some View {
    ZStack {
        Rectangle()
            .fill(GlobalConstants.backgroundTopColor)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .edgesIgnoringSafeArea(.all)
        content()
    }
}

struct ChargingView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingView()
            .environment(\.colorScheme, .dark)
    }
}
