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
    }

    // MARK: - Public properties

    var body: some View {
        ZStack {
            Constants.backgroundTopColor
                .ignoresSafeArea()
            VStack {
                headBarView
                settingsValueView
                settingsDisclosureGroupView.padding()
                Spacer()
            }
            activateSystemBottomSheetView
        }
    }

    // MARK: - Private properties

    @GestureState private var gestureOffset = CGSize.zero
    @State private var currentMenuOffsetY: CGFloat = 0.0
    @State private var lastMenuOffsetY: CGFloat = 0.0
    @State private var isCarClosed = false
    @State private var tagSelected = 0
    @State private var acSliderValue: Float = 0.0
    @State private var shadowRadius = 0.0
    @State private var completionAmout = 0.0
    @State private var selectedColor = Color.white
    @State private var temp = 15.0

    private var goPreviusScreenButtonView: some View {
        ZStack {
            Circle()
                .fill(Constants.backgroundTopColor)
                .shadow(color: .gray, radius: 5, x: -3, y: -3)
                .shadow(color: .black, radius: 5, x: 5, y: 5)
                .frame(width: 73, height: 73)
            Button {

            } label: {
                Image(systemName: Constants.goPreviusButtonImageName)
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .settingsNeumorfismSelectedCircleStyle()
            }
        }
    }

    private var settingsButtonView: some View {
        ZStack {
            Circle()
                .fill(Constants.backgroundTopColor)
                .shadow(color: .gray, radius: 5, x: -3, y: -3)
                .shadow(color: .black, radius: 5, x: 5, y: 5)
                .frame(width: 73, height: 73)
            Button {

            } label: {
                Image(systemName: Constants.settingsGearshapeImageName)
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .settingsNeumorfismUnSelectedCircleStyle()
            }
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
            settingsButtonView
        }
    }


    private var settingsValueView: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 151, height: 151)
            Circle()
                .stroke( // 1
                    LinearGradient(colors: [.gray, .black], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 30
                )
                .shadow(color: .gray, radius: 5, x: -5, y: -5)
                .shadow(color: .black, radius: 5, x: 5, y: 5)
                .frame(width: 150, height: 150)
            Circle()
                .trim(from: 0, to: completionAmout)
                .stroke( // 1
                    LinearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottom),
                    lineWidth: 30
                )
                .shadow(color: .red, radius: shadowRadius, x: 0, y: 0)
                .shadow(color: .yellow, radius: shadowRadius, x: 0, y: 0)
                .rotationEffect(Angle(degrees: 90))
                .frame(width: 150, height: 150)
            Circle()
                .stroke( // 1
                    LinearGradient(colors: [.clear, .black], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 1
                )
                .frame(width: 178, height: 178)
                .opacity(0.5)
            Text("\(Int(temp))c")
                .font(Font.system(size: 45))
                .foregroundColor(selectedColor)
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
        CustomSlider(value: Binding(get: {
            self.temp
        }, set: { newValue in
            guard
                newValue >= 15,
                newValue < 31,
                newValue > self.temp
            else {
                guard
                    self.temp > 15,
                    self.temp > newValue
                else { return }
                withAnimation {
                    self.completionAmout -= 0.073
                    self.temp = newValue
                    self.shadowRadius -= 1
                }
                return
            }
            withAnimation {
                self.temp = newValue
                self.completionAmout += 0.073
                self.shadowRadius += 1
            }
        }),
                     in: 15...30,
                     step: 1.0,
                     track: {
            Capsule()
                .foregroundColor(.gray)
                .frame(width: 200, height: 5)
        }, fill: {
            Capsule()
                .foregroundColor(Constants.topLockGradient)
        }, thumb: {
            Image(Constants.thumbImageName)
                .offset(y: 6)
        }, thumbSize: CGSize(width: 15, height: 15))
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
        CustomSlider(value: $acSliderValue,
                     in: 0...255,
                     track: {
            Capsule()
                .foregroundColor(.gray)
                .frame(width: 200, height: 5)
        }, fill: {
            Capsule()
                .foregroundColor(Constants.topLockGradient)
        }, thumb: {
            Image(Constants.thumbImageName)
                .offset(y: 6)
        }, thumbSize: CGSize(width: 15, height: 15))
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

    // MARK: - HEATSETTINGS

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
        CustomSlider(value: $acSliderValue,
                     in: 0...255,
                     track: {
            Capsule()
                .foregroundColor(.gray)
                .frame(width: 200, height: 5)
        }, fill: {
            Capsule()
                .foregroundColor(Constants.topLockGradient)
        }, thumb: {
            Image(Constants.thumbImageName).offset(y: 6)
        }, thumbSize: CGSize(width: 15, height: 15))
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

    // MARK: - HEATSETTINGS

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
        CustomSlider(value: $acSliderValue,
                     in: 0...255,
                     track: {
            Capsule()
                .foregroundColor(Constants.topLockGradient)
                .frame(width: 200, height: 5)
        }, fill: {
            Capsule()
                .foregroundColor(Constants.topLockGradient)
        }, thumb: {
            Image(Constants.thumbImageName)
                .offset(y: 6)
        }, thumbSize: CGSize(width: 15, height: 15))
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
                    if -currentMenuOffsetY > maxHeight / 10 {
                        currentMenuOffsetY = -160
                    } else {
                        currentMenuOffsetY = 0
                    }
                    lastMenuOffsetY = currentMenuOffsetY
                }
            }
    }

    private var activateSystemBottomSheetView: some View {
        ZStack {
            Constants.backgroundTopColor
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 1)
                .foregroundColor(Constants.backgroundTopColor)
            VStack {
                Capsule()
                    .fill(Color.black)
                    .frame(width: 80, height: 3)
                HStack {
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
                    ZStack {
                        Circle()
                            .fill(Constants.topLockGradient)
                            .shadow(color: .gray, radius: 5, x: -3, y: -3)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                            .frame(width: 60, height: 60)
                        Button {

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
                .padding(.top, 40)
                HStack {
                    colorPickerView.padding()
                    temputareStepperView.padding()
                    colorPickerView.padding()
                }
            }
        }
        .frame(height: 150)
        .offset(y: 470)
        .offset(y: currentMenuOffsetY)
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



    private var colorPickerView: some View {
        ColorPicker(selection: $selectedColor) {
            Text(Constants.colorPickerText)
                .frame(width: 70)
                .rotationEffect(Angle(degrees: 90))
        }
        .padding(.leading)
        .rotationEffect(Angle(degrees: -90))
        .frame(width: 60, height: 100)
    }

    private var temputareStepperView: some View {
        Stepper(value: Binding(get: {
            self.temp
        }, set: { newValue in
            withAnimation {
                guard
                    newValue >= self.temp,
                    newValue >= 15,
                    newValue < 31
                else {
                    guard
                        self.temp > 15,
                        self.temp > newValue
                    else { return }
                    self.temp = newValue
                    self.completionAmout -= 1/15
                    self.shadowRadius -= 1
                    return
                }
                self.temp = newValue
                self.completionAmout += 1/15
                self.shadowRadius += 1
            }
        })) {
            EmptyView()
        }
        .frame(width: 100)
    }

    // MARK: - Private methods

    private func onChangeMenuOffset() {
        DispatchQueue.main.async {
            currentMenuOffsetY = gestureOffset.height + lastMenuOffsetY

        }
    }
}

struct SettingsNeumorfismUnselected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: -5, y: -5)
            .shadow(color: Color(GlobalConstants.darkShadowColorName), radius: 5, x: 5, y: 5)
    }
}

struct SettingsNeumorfismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: 5, y: 5)
            .shadow(color: Color(GlobalConstants.lightShadowColorName), radius: 5, x: -5, y: -5)
    }
}

struct SettingsNeumorfismUnSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(
                Circle()
                    .stroke(LinearGradient(colors: [.gray, .black], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 2))
            )
    }
}

struct SettingsNeumorfismSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(
                Circle()
                    .stroke(LinearGradient(colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 2))
            )
    }
}

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
}
