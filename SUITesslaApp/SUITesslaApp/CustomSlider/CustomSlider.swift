//
//  CustomSlider.swift
//  SUITesslaApp
//
//  Created by Григоренко Александр Игоревич on 01.02.2023.
//

import SwiftUI

/// Кастомный слайдер c гита.
struct CustomSlider<Value, Track, Fill, Thumb>: View
where Value: BinaryFloatingPoint,
      Value.Stride: BinaryFloatingPoint,
      Track: View,
      Fill: View,
      Thumb: View {

    // MARK: - Public properties

    let bounds: ClosedRange<Value>
    let step: Value
    let minimumValueLabel: Text?
    let maximumValueLabel: Text?
    let onEditingChanged: ((Bool) -> Void)?
    let track: () -> Track
    let fill: (() -> Fill)?
    let thumb: () -> Thumb
    let thumbSize: CGSize

    @Binding var value: Value

    // MARK: - Private properties

    @State private var xOffset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var trackSize: CGSize = .zero

    // MARK: - init

    init(value: Binding<Value>,
         in bounds: ClosedRange<Value> = 0...1,
         step: Value = 0.001,
         minimumValueLabel: Text? = nil,
         maximumValueLabel: Text? = nil,
         onEditingChanged: ((Bool) -> Void)? = nil,
         track: @escaping () -> Track,
         fill: (() -> Fill)?,
         thumb: @escaping () -> Thumb,
         thumbSize: CGSize) {
        _value = value
        self.bounds = bounds
        self.step = step
        self.minimumValueLabel = minimumValueLabel
        self.maximumValueLabel = maximumValueLabel
        self.onEditingChanged = onEditingChanged
        self.track = track
        self.fill = fill
        self.thumb = thumb
        self.thumbSize = thumbSize
    }

    private var percentage: Value {
        1 - (bounds.upperBound - value) / (bounds.upperBound - bounds.lowerBound)
    }

    private var fillWidth: CGFloat {
        trackSize.width * CGFloat(percentage)
    }

    var body: some View {
        HStack {
            minimumValueLabel
            ZStack {
                track()
                    .measureSize {
                        let firstInit = (trackSize == .zero)
                        trackSize = $0
                        if firstInit {
                            xOffset = (trackSize.width - thumbSize.width) * CGFloat(percentage)
                            lastOffset = xOffset
                        }
                    }
                fill?()
                    .position(x: fillWidth - trackSize.width / 2, y: trackSize.height / 2)
                    .frame(width: fillWidth, height: trackSize.height)
            }
            .frame(width: trackSize.width, height: trackSize.height)
            .overlay(
                thumb()
                    .position(
                        x: thumbSize.width / 2,
                        y: thumbSize.height / 2
                    )
                    .frame(width: thumbSize.width, height: thumbSize.height)
                    .offset(x: xOffset)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged(
                                { gestureValue in
                        if abs(gestureValue.translation.width) < 0.1 {
                            lastOffset = xOffset
                            onEditingChanged?(true)
                        }
                        let availableWidth = trackSize.width - thumbSize.width
                        xOffset = max(0, min(lastOffset + gestureValue.translation.width, availableWidth))
                        let newValue = (bounds.upperBound - bounds.lowerBound) * Value(xOffset / availableWidth) + bounds.lowerBound
                        let steppedNewValue = (round(newValue / step) * step)
                        value = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
                    }).onEnded({ _ in
                        onEditingChanged?(false)
                    })),
                alignment: .leading)

            maximumValueLabel
        }
        .frame(height: max(trackSize.height, thumbSize.height))
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self,
                                   value: geometry.size)
        })
    }
}

extension View {
    func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
        self.modifier(MeasureSizeModifier())
            .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}
