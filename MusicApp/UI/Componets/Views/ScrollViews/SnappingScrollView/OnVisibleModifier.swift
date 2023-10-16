//
//  OnVisibleModifier.swift
//  MusicApp
//
//  Created by iMac on 16.10.2023.
//

import SwiftUI

internal struct OnVisibleModifier: ViewModifier {
    @Environment(\.scrollViewFrame) private var scrollViewFrame
    @State private var isVisible: Bool? = nil
    
    var action: (Bool) -> Void
    var insets: EdgeInsets
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    let isVisible = scrollViewFrame?.intersects(geometry.frame(in: .global))
                    
                    Color.clear
                        .onAppear { onVisible(isVisible) }
                        .onChange(of: isVisible) { _, newValue in
                           onVisible(newValue)
                        }
                }
                .padding(insets.negated())
                .hidden()
            )
    }
    
    private func onVisible(_ newValue: Bool?) {
        if let newValue = newValue, isVisible != newValue {
            isVisible = newValue
            action(newValue)
        }
    }
}

extension EdgeInsets {
    func negated() -> EdgeInsets {
        var insets = self
        insets.negate()
        return insets
    }
}

internal extension EnvironmentValues {
    var scrollViewFrame: CGRect? {
        get { self[ScrollViewFrameKey.self] }
        set { self[ScrollViewFrameKey.self] = newValue }
    }
}

private struct ScrollViewFrameKey: EnvironmentKey {
    static let defaultValue: CGRect? = nil
}

public extension View {
    
    /// Sets the scroll snapping anchor rect for this view.
    ///
    /// A parent `SnappingScrollView` will prefer to end scrolling
    /// outside, or on an edge, of the anchor rect defined by the source.
    ///
    /// Avoid setting the scroll snapping anchor rect on a child of a lazy
    /// view, such as a `LazyHGrid`, `LazyVGrid`, `LazyHStack`
    /// or `LazyVStack`.
    ///
    /// - Parameters:
    ///   - source: The source of the anchor rect.
    func scrollSnappingAnchor(_ source: Anchor<CGRect>.Source?) -> some View {
        anchorPreference(key: AnchorsKey.self, value: source ?? .bounds) {
            source != nil ? [$0] : []
        }
    }
}

public extension View {
    
    /// Adds an action to perform when this view's bounds moves into or
    /// out of the visible frame.
    ///
    /// You can use `onVisible` when the view is a child of a
    /// `SnappingScrollView`.
    ///
    /// `onVisible` is called on the main thread. Avoid performing
    /// long-running tasks on the main thread. If you need to perform a
    /// long-running task in response to the visibility changing, you should
    /// dispatch to a background queue.
    ///
    /// - Parameters:
    ///   - padding: The padding around all edges of the view's bounds.
    ///   The default value for this parameter is `0`.
    ///   - action: A closure to run when the visibility changes.
    ///   - isVisible: The view's visibility.
    @inlinable func onVisible(padding length: CGFloat = 0, action: @escaping (_ isVisible: Bool) -> Void) -> some View {
        onVisible(padding: EdgeInsets(top: length, leading: length, bottom: length, trailing: length),
                  action: action)
    }
    
    /// Adds an action to perform when this view's bounds moves into or
    /// out of the visible frame.
    ///
    /// You can use `onVisible` when the view is a child of a
    /// `SnappingScrollView`.
    ///
    /// `onVisible` is called on the main thread. Avoid performing
    /// long-running tasks on the main thread. If you need to perform a
    /// long-running task in response to the visibility changing, you should
    /// dispatch to a background queue.
    ///
    /// - Parameters:
    ///   - padding: The padding around each edge of the view's bounds.
    ///   - action: A closure to run when the visibility changes.
    ///   - isVisible: The new value that failed the comparison check.
    func onVisible(padding insets: EdgeInsets, action: @escaping (_ isVisible: Bool) -> Void) -> some View {
        modifier(OnVisibleModifier(action: action, insets: insets))
    }
}

internal struct AnchorsKey: PreferenceKey {
    static let defaultValue = [Anchor<CGRect>]()
    
    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> [Anchor<CGRect>]) {
        value.append(contentsOf: nextValue())
    }
}
