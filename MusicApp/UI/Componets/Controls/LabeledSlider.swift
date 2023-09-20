//
//  LabeledSlider.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 03.02.2023.
//

import SwiftUI

struct LabeledSlider<Label: View, ValueLabel: View>: View {
   @Environment(\.mySliderStyle) private var style
   
   @Binding var value: Double
   var bounds: ClosedRange<Double>
   var label: Label
   var minimumValueLabel: ValueLabel
   var maximumValueLabel: ValueLabel
   var onValueChanged: (Double) -> Void
   
   init(value: Binding<Double>,
        in bounds: ClosedRange<Double> = 0...1,
        @ViewBuilder label: () -> Label,
        minimumValueLabel: () -> ValueLabel,
        maximumValueLabel: () -> ValueLabel,
        onValueChanged: @escaping (Double) -> Void = { _ in }) {
      
      self._value = value
      self.bounds = bounds
      self.label = label()
      self.minimumValueLabel = minimumValueLabel()
      self.maximumValueLabel = maximumValueLabel()
      self.onValueChanged = onValueChanged
   }
   
   var body: some View {
      let configuration = MySliderStyleConfiguration(
         value: $value,
         bounds: bounds,
         label: label,
         minimumValueLabel: minimumValueLabel,
         maximumValueLabel: maximumValueLabel,
         onValueChanged: onValueChanged
      )
      
      AnyView(style.resolve(configuration: configuration))
         .accessibilityElement(children: .combine)
         .accessibilityValue(valueText)
         .accessibilityAdjustableAction { direction in
            let boundsLength = bounds.upperBound - bounds.lowerBound
            let step = boundsLength / 10
            switch direction {
            case .increment:
               value = max(value + step, bounds.lowerBound)
            case .decrement:
               value = max(value - step, bounds.lowerBound)
            @unknown default:
               break
            }
         }
   }
   
   var valueText: Text {
      if bounds == 0.0...1.0 {
         return Text(value, format: .percent)
      } else {
         return Text(value, format: .number)
      }
   }
}

// MARK: - Style Configuration Initializer

extension LabeledSlider where Label == MySliderStyleConfiguration.Label, ValueLabel == MySliderStyleConfiguration.ValueLabel {
   init(_ configuration: MySliderStyleConfiguration) {
      self._value = configuration.$value
      self.bounds = configuration.bounds
      self.label = configuration.label
      self.minimumValueLabel = configuration.minimumValueLabel
      self.maximumValueLabel = configuration.maximumValueLabel
      self.onValueChanged = configuration.onValueChanged
   }
}

// MARK: - Style Protocol

protocol LabeledSliderStyle: DynamicProperty {
   associatedtype Body: View
   @ViewBuilder func makeBody(configuration: Configuration) -> Body
   typealias Configuration = MySliderStyleConfiguration
}

// MARK: - Resolved Style

extension LabeledSliderStyle {
   func resolve(configuration: Configuration) -> some View {
      ResolvedMySliderStyle(configuration: configuration, style: self)
   }
}

struct ResolvedMySliderStyle<Style: LabeledSliderStyle>: View {
   var configuration: Style.Configuration
   var style: Style
   
   var body: Style.Body {
      style.makeBody(configuration: configuration)
   }
}

// MARK: - Style Configuration

struct MySliderStyleConfiguration {
   struct Label: View {
      let underlyingLabel: AnyView
      
      init(_ label: some View) {
         self.underlyingLabel = AnyView(label)
      }
      
      var body: some View {
         underlyingLabel
      }
   }
   
   struct ValueLabel: View {
      let underlyingLabel: AnyView
      
      init(_ label: some View) {
         self.underlyingLabel = AnyView(label)
      }
      
      var body: some View {
         underlyingLabel
      }
   }
   
   @Binding var value: Double
   let bounds: ClosedRange<Double>
   let label: Label
   let minimumValueLabel: ValueLabel
   let maximumValueLabel: ValueLabel
   let onValueChanged: (Double) -> Void
   
   init<Label: View, ValueLabel: View>(
      value: Binding<Double>,
      bounds: ClosedRange<Double>,
      label: Label,
      minimumValueLabel: ValueLabel,
      maximumValueLabel: ValueLabel,
      onValueChanged: @escaping (Double) -> Void
   ) {
      self._value = value
      self.bounds = bounds
      self.label = label as? MySliderStyleConfiguration.Label ?? .init(label)
      self.minimumValueLabel = minimumValueLabel as? MySliderStyleConfiguration.ValueLabel ?? .init(minimumValueLabel)
      self.maximumValueLabel = maximumValueLabel as? MySliderStyleConfiguration.ValueLabel ?? .init(maximumValueLabel)
      self.onValueChanged = onValueChanged
   }
}

// MARK: - Environment

struct MySliderStyleKey: EnvironmentKey {
   static var defaultValue: any LabeledSliderStyle = DefaultMySliderStyle()
}

extension EnvironmentValues {
   var mySliderStyle: any LabeledSliderStyle {
      get { self[MySliderStyleKey.self] }
      set { self[MySliderStyleKey.self] = newValue }
   }
}

extension View {
   func mySliderStyle(_ style: some LabeledSliderStyle) -> some View {
      environment(\.mySliderStyle, style)
   }
}

// MARK: - Default Style

struct DefaultMySliderStyle: LabeledSliderStyle {
   func makeBody(configuration: Configuration) -> some View {
      Slider(
         value: configuration.$value,
         in: configuration.bounds,
         label: { configuration.label },
         minimumValueLabel: { configuration.minimumValueLabel },
         maximumValueLabel: { configuration.maximumValueLabel }
      )
   }
}

extension LabeledSliderStyle where Self == DefaultMySliderStyle {
   static var `default`: Self { .init() }
}

// MARK: - Custom Style

struct CustomSliderStyle: LabeledSliderStyle {
   @Environment(\.isEnabled) var isEnabled
   @GestureState var value: Double?
   @State private var isDragging = false
   @State private var lineProxyWidth: CGFloat = 0
   private var scaleAnimationDuration = 0.15
   
   func drag(updating value: Binding<Double>, in bounds: ClosedRange<Double>) -> some Gesture {
      DragGesture(minimumDistance: 0)
         .updating($value) { dragValue, state, _ in
            if state == nil {
               state = value.wrappedValue
            }
         }
         .onChanged { dragValue in
            isDragging = true
            if let newValue = valueForTranslation(dragValue.translation.width, in: bounds, width: lineProxyWidth) {
               value.wrappedValue = newValue
            }
         }
         .onEnded { dragValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + scaleAnimationDuration) {
               isDragging = false
            }
            if let newValue = valueForTranslation(dragValue.translation.width, in: bounds, width: lineProxyWidth) {
               value.wrappedValue = newValue
            }
         }
   }
   
   func makeBody(configuration: Configuration) -> some View {
      HStack {
         configuration.minimumValueLabel
            .foregroundStyle(isEnabled ? (isDragging ?  AnyShapeStyle(.white) : AnyShapeStyle(Color.lightGrayColor)) : AnyShapeStyle(.bar))
         
         GeometryReader { lineProxy in
            ZStack(alignment: .leading) {
               Rectangle()
                  .fill(Color.lightGrayColor2)
               Rectangle()
                  .foregroundStyle(isEnabled ? (isDragging ? AnyShapeStyle(.white) : AnyShapeStyle(Color.lightGrayColor)) : AnyShapeStyle(.bar))
                  .frame(width: relativeValue(for: configuration.value, in: configuration.bounds) * lineProxy.size.width)
                  .animation(.linear, value: configuration.value)
               
            }
            .clipShape(Capsule(style: .continuous))
            
            .onAppear {
               self.lineProxyWidth = lineProxy.size.width
            }
         }
         .frame(height: isDragging ? Metric.timeLineHeight * 2 : Metric.timeLineHeight)
         
         configuration.maximumValueLabel
            .foregroundStyle(isEnabled ? (isDragging ?  AnyShapeStyle(.white) : AnyShapeStyle(.tint)) : AnyShapeStyle(Color.lightGrayColor))
      }
      .frame(height: Metric.volumeSliderHeight)
      .contentShape(Rectangle())
      .gesture(drag(updating: configuration.$value, in: configuration.bounds))
      .scaleEffect(x: isDragging ? 1.06 : 1, y: isDragging ? 1.16 : 1)
      .animation(.linear(duration: scaleAnimationDuration), value: isDragging)
      
      .onChange(of: value ?? 0) { value in
         configuration.onValueChanged(value)
      }
   }
   
   func relativeValue(for value: Double, in bounds: ClosedRange<Double>) -> Double {
      let boundsLength = bounds.upperBound - bounds.lowerBound
      let fraction = (value - bounds.lowerBound) / boundsLength
      return max(0, min(fraction, 1))
   }
   
   func valueForTranslation(_ x: Double, in bounds: ClosedRange<Double>, width: Double) -> Double? {
      guard let initialValue = value, width > 0 else { return nil }
      let relativeTranslation = x / width
      let boundsLength = bounds.upperBound - bounds.lowerBound
      let scaledTranslation = relativeTranslation * boundsLength
      let newValue = initialValue + scaledTranslation
      let clamped = max(bounds.lowerBound, min(newValue, bounds.upperBound))
      return clamped
   }
}

extension LabeledSliderStyle where Self == CustomSliderStyle {
   static var custom: Self { .init() }
}

