//
//  SettingsScreen.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 31.01.2023.
//

import SwiftUI

/// Представление экрана с настройками
struct SettingsScreenView: View {

    // MARK: - Private constants

    private enum Constants {
        static let backgroundColor: Color = .black
        static let backgroundTopColor: Color = Color("NBackground")
        static let bottomLockGradient: Color = Color("BottomGradient")
        static let topLockGradient: Color = Color("TopGradient")
        static let goPreviusButtonImageName = "chevron.left"
        static let settingsGearshapeImageName = "gearshape"
        static let climateTextViewText = "Climate"
        static let conditionTextViewText = "Ac"
        static let conditionImageName = "snowflake"
        static let thumbImageName = "Knob"
        static let fanSettingsNameText = "Fan"
        static let heatSettingsNameText = "Heat"
        static let heatSettingsImageName = "water.waves"
        static let autoSettingsName = "Auto"
        static let autoImageName = "timer"
        static let actionSheetTitleText = "A/C is ON"
        static let actionSheetSubtitleText = "Tap to turn off or swipe up for a fast setup"
        static let settingsDisclosureGroupText = "Settings"
        static let colorPickerText = "Color"
        static let fanImageName = "wind"
        static let lockFillImageName = "lock.fill"
        static let ventilateViewImageView = "Union"
        static let ventilateText = "Vent"
        static let supportAlertText = "Tesla Support"
        static let supportAlertURL = "https://www.tesla.com/support"
        static let suppirtAlertButtonText = "Close"
        static let onActivateImageName = "activate"
        static let onButtonText = "On"
    }

    // MARK: - Public properties

    var body: some View {
        ZStack {
            Constants.backgroundTopColor
                .ignoresSafeArea()
            VStack {
                headBarView
                settingsValueView
                settingsDisclosureGroupView
                    .padding()
                Spacer()
            }
            activateSystemBottomSheetView
            if settingsScreenViewModel.isSupportAlertShown {
                supportAlertView
            }
        }.navigationBarBackButtonHidden(true)
    }

    // MARK: - Private properties

    @StateObject var settingsScreenViewModel = SettingsScreenViewModel()
    @GestureState private var gestureOffset = CGSize.zero

    private var goPreviusShadowCircle: some View {
        Circle()
            .fill(Constants.backgroundTopColor)
            .shadow(color: .gray, radius: 5, x: -3, y: -3)
            .shadow(color: .black, radius: 5, x: 5, y: 5)
            .frame(width: 73, height: 73)
    }

    private var goPreviusScreenButton: some View {
        Button {

        } label: {
            Image(systemName: Constants.goPreviusButtonImageName)
                .renderingMode(.template)
                .foregroundColor(.gray)
                .frame(width: 50, height: 50)
                .settingsNeumorfismUnSelectedCircleStyle()
        }
    }



    private var settingsButtonView: some View {
        Button {
            settingsScreenViewModel.showSupprotAlert()
        } label: {
            Image(systemName: Constants.settingsGearshapeImageName)
                .renderingMode(.template)
                .foregroundColor(.gray)
                .frame(width: 50, height: 50)
                .settingsNeumorfismUnSelectedCircleStyle()
        }
    }

    private var supportAlertView: some View {
            VStack {
                Link(Constants.supportAlertText, destination: URL(string: Constants.supportAlertURL)!)
                    .foregroundColor(Constants.backgroundTopColor)
                    .font(Font.system(size: 25))
                    .padding()
                Button(Constants.suppirtAlertButtonText) {
                    settingsScreenViewModel.isSupportAlertShown = false
                }
                .foregroundColor(Constants.backgroundTopColor)
                .font(Font.system(size: 25))
                .padding([.leading, .trailing, .bottom])
            }
            .background(Color.gray)
            .cornerRadius(15)
    }

    private var settingsView: some View {
        ZStack {
            goPreviusShadowCircle
            settingsButtonView
        }
    }

    private var goPreviusScreenButtonView: some View {
        ZStack {
            goPreviusShadowCircle
            goPreviusScreenButton
        }
    }

    private var climateTextView: some View {
        Text(Constants.climateTextViewText)
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

    private var settingsValueInternalCircleView: some View {
        Circle()
            .fill(LinearGradient(colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 151, height: 151)
    }

    private var settingsValueFakeProgressCircleView: some View {
        Circle()
            .stroke(
                LinearGradient(colors: [.gray, .black], startPoint: .topLeading, endPoint: .bottomTrailing),
                lineWidth: 30
            )
            .shadow(color: .gray, radius: 5, x: -5, y: -5)
            .shadow(color: .black, radius: 5, x: 5, y: 5)
            .frame(width: 150, height: 150)
    }

    private var settingsValueProgressCircleView: some View {
        Circle()
            .trim(from: 0, to: settingsScreenViewModel.completionAmout)
            .stroke(
                LinearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottom),
                lineWidth: 30
            )
            .shadow(color: .red, radius: settingsScreenViewModel.shadowRadius, x: 0, y: 0)
            .shadow(color: .yellow, radius: settingsScreenViewModel.shadowRadius, x: 0, y: 0)
            .rotationEffect(Angle(degrees: 90))
            .frame(width: 150, height: 150)
    }

    private var settingsValueStrokeView: some View {
        Circle()
            .stroke(
                LinearGradient(colors: [.clear, .black], startPoint: .topLeading, endPoint: .bottomTrailing),
                lineWidth: 1
            )
            .frame(width: 178, height: 178)
            .opacity(0.5)
    }

    private var settingsValueTextView: some View {
        Text("\(settingsScreenViewModel.isSystemOn ? Int(settingsScreenViewModel.temp) : 0)c")
            .font(Font.system(size: 45))
            .foregroundColor(settingsScreenViewModel.selectedColor)
    }

    private var settingsValueView: some View {
        ZStack {
            settingsValueInternalCircleView
            settingsValueFakeProgressCircleView
            settingsValueProgressCircleView
            settingsValueStrokeView
            settingsValueTextView
        }
    }

    private var acSettingsNameView: some View {
        Text(Constants.conditionTextViewText)
            .font(Font.system(size: 13))
    }

    private var acImageNameView: some View {
        Image(systemName: Constants.conditionImageName)
            .renderingMode(.template)
            .foregroundColor(Constants.topLockGradient)
            .frame(width: 30, height: 30)
            .settingsNeumorfismUnSelectedCircleStyle()
    }

    private var acSliderNameView: some View {
        CarSettingsSlider(
            value: Binding(
                get: {
                    self.settingsScreenViewModel.temp
                },
                set: { newValue in
                    withAnimation {
                        self.settingsScreenViewModel.setTemp(temp: newValue)
                    }
                }
            ),
            in: 15...30,
            step: 1.0,
            track: {
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 5)
            },
            fill: {
                Capsule()
                    .foregroundColor(Constants.topLockGradient)
            },
            thumb: {
                Image(Constants.thumbImageName)
                    .offset(y: 6)
            },
            thumbSize: CGSize(width: 15, height: 15))
    }

    private var sliderView: some View {
        HStack {
            acSettingsNameView
            acImageNameView
                .padding()
            acSliderNameView
                .padding()
        }
    }

    private var fanSettingsNameView: some View {
        Text(Constants.fanSettingsNameText)
            .font(Font.system(size: 13))
    }

    private var fanImageNameView: some View {
        Image(systemName: Constants.fanImageName)
            .renderingMode(.template)
            .foregroundColor(Constants.topLockGradient)
            .frame(width: 30, height: 30)
            .settingsNeumorfismUnSelectedCircleStyle()
    }

    private var fanSliderNameView: some View {
        CarSettingsSlider(
            value: $settingsScreenViewModel.fanSliderValue,
            in: 15...30,
            step: 1.0,
            track: {
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 5)
            },
            fill: {
                Capsule()
                    .foregroundColor(Constants.topLockGradient)
            },
            thumb: {
                Image(Constants.thumbImageName)
                    .offset(y: 6)
            },
            thumbSize: CGSize(width: 15, height: 15))
    }

    private var fanSliderView: some View {
        HStack {
            fanSettingsNameView
            fanImageNameView
                .padding()
            fanSliderNameView
                .padding()
        }
    }

    private var heatSettingsNameView: some View {
        Text(Constants.heatSettingsNameText)
            .font(Font.system(size: 13))
    }

    private var heatImageNameView: some View {
        Image(systemName: Constants.heatSettingsImageName)
            .renderingMode(.template)
            .foregroundColor(Constants.topLockGradient)
            .frame(width: 30, height: 30)
            .settingsNeumorfismUnSelectedCircleStyle()
    }

    private var heatSliderNameView: some View {
        CarSettingsSlider(
            value: $settingsScreenViewModel.heatSliderValue,
            in: 15...30,
            step: 1.0,
            track: {
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 5)
            },
            fill: {
                Capsule()
                    .foregroundColor(Constants.topLockGradient)
            },
            thumb: {
                Image(Constants.thumbImageName)
                    .offset(y: 6)
            },
            thumbSize: CGSize(width: 15, height: 15))
    }

    private var heatSliderView: some View {
        HStack {
            heatSettingsNameView
            heatImageNameView
                .padding()
            heatSliderNameView
                .padding()
        }
    }

    private var autoSettingsNameView: some View {
        Text(Constants.autoSettingsName)
            .font(Font.system(size: 13))
    }

    private var autoImageNameView: some View {
        Image(systemName: Constants.autoImageName)
            .renderingMode(.template)
            .foregroundColor(Constants.topLockGradient)
            .frame(width: 30, height: 30)
            .settingsNeumorfismUnSelectedCircleStyle()
    }

    private var autoSliderNameView: some View {
        CarSettingsSlider(
            value: $settingsScreenViewModel.autoSliderValue,
            in: 15...30,
            step: 1.0,
            track: {
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 5)
            },
            fill: {
                Capsule()
                    .foregroundColor(Constants.topLockGradient)
            },
            thumb: {
                Image(Constants.thumbImageName)
                    .offset(y: 6)
            },
            thumbSize: CGSize(width: 15, height: 15))
    }

    private var autoSliderView: some View {
        HStack {
            autoSettingsNameView
            autoImageNameView
                .padding()
            autoSliderNameView
                .padding()
        }
    }

    private var settingsVstackView: some View {
        VStack(spacing: 0) {
            sliderView
            fanSliderView
            heatSliderView
            autoSliderView
        }
        .disabled(!settingsScreenViewModel.isSystemOn)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { value in
                let maxHeight = UIScreen.main.bounds.height - 100
                withAnimation {
                    self.settingsScreenViewModel.setActionSheetPoint(maxHeight: maxHeight)
                }
            }
    }

    private var actionSheetTextView: some View {
        VStack {
            HStack {
                Text(Constants.actionSheetTitleText)
                    .bold()
                Spacer()
            }
            HStack {
                Text(Constants.actionSheetSubtitleText)
                    .font(Font.system(size: 14))
                    .foregroundColor(.gray)
                Spacer()
            }
        }.padding(.leading)
    }

    private var actionSheertButtonView: some View {
        ZStack {
            Circle()
                .fill(Constants.topLockGradient)
                .shadow(color: .gray, radius: 5, x: -3, y: -3)
                .shadow(color: .black, radius: 5, x: 5, y: 5)
                .frame(width: 60, height: 60)
            Button {
                settingsScreenViewModel.activateSystem()
            } label: {
                Image(systemName: Constants.lockFillImageName)
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .settingsNeumorfismUnSelectedCircleStyle()
            }
        }
        .padding(.trailing)
    }

    private var activateSystemBottomSheetView: some View {
        ZStack {
            Constants.backgroundTopColor
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 1)
                .foregroundColor(Constants.backgroundTopColor)
            VStack(spacing: 50) {
                Capsule()
                    .fill(Color.black)
                    .frame(width: 80, height: 3)
                HStack {
                    actionSheetTextView
                    actionSheertButtonView
                }
                .offset(y: -30)
                HStack {
                    activateButton.padding()
                    temputareStepperView.padding()
                    ventilateView.padding()
                }
            }
        }
        .frame(height: 150)
        .offset(y: 450)
        .offset(y: settingsScreenViewModel.currentMenuOffsetY)
        .gesture(dragGesture)
    }

    private var settingsDisclosureGroupView: some View {
        DisclosureGroup {
            settingsVstackView
        } label: {
            Text(Constants.settingsDisclosureGroupText)
                .foregroundColor(.gray)
        }
        .accentColor(.gray)
    }

    private var activateButton: some View {
        VStack(spacing: 45) {
            Image(Constants.onActivateImageName)
            Text(Constants.onButtonText)
        }.offset(y: -20)
    }

    private var temputareStepperView: some View {
        CustomStepper(isStarted: $settingsScreenViewModel.isStepperStarted, value: Binding(get: {
            self.settingsScreenViewModel.temp
        }, set: { newValue in
            withAnimation {
                self.settingsScreenViewModel.setTempWithStepper(temp: newValue)
            }
        }))
    }

    private var ventilateView: some View {
        VStack() {
            Image(Constants.ventilateViewImageView)
                .resizable()
                .scaledToFit()
                .offset(y: -35)
                .frame(width: 25)
            Text(Constants.ventilateText)
        }
    }

    // MARK: - Private methods

    private func onChangeMenuOffset() {
        DispatchQueue.main.async {
            settingsScreenViewModel.setCurrenActionSheertYOffset(size: gestureOffset)
        }
    }
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreenView()
            .environment(\.colorScheme, .dark)
    }
}
