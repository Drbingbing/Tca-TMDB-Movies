//
//  OffsetObservingScrollView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/28.
//

import SwiftUI

struct OffsetObservingScrollView<Content: View>: View {
    
    var axes: Axis.Set
    var showIndicators: Bool
    @Binding var offset: CGPoint
    var content: Content
    
    init(_ axes: Axis.Set = [.vertical], showIndicators: Bool = true, offset: Binding<CGPoint>, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showIndicators = showIndicators
        _offset = offset
        self.content = content()
    }
    
    /// The name of our coordinate space doesn't have to be
    /// stable between view updates (it just needs to be
    /// consistent within this view), so we'll simply use a
    /// plain UUID for it:
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axes, showsIndicators: showIndicators) {
            ZStack(alignment: .top) {
                PositionObservingView(
                    coordinateSpace: .named(coordinateSpaceName),
                    position: Binding(
                        get: { offset },
                        set: { newOffset in
                            offset = CGPoint(
                                x: -newOffset.x,
                                y: -newOffset.y
                            )
                        }
                    )
                )
                
                content
            }
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

private struct PositionObservingView: View {
    var coordinateSpace: CoordinateSpace
    
    @Binding var position: CGPoint
    
    init(coordinateSpace: CoordinateSpace, position: Binding<CGPoint>) {
        self.coordinateSpace = coordinateSpace
        _position = position
    }
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(
                key: PreferenceKey.self,
                value: geometry.frame(in: .named(coordinateSpace)).origin
            )
        }
        .onPreferenceChange(PreferenceKey.self) { position in
            self.position = position
        }
    }
}

extension PositionObservingView {
    private struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
}

#Preview {
    
    @State var offset = CGPoint.zero
    return OffsetObservingScrollView(offset: $offset) {
        ForEach(0...100, id: \.self) { _ in
            Color.sonicSilver
                .padding(.horizontal, 20)
                .frame(height: 20)
        }
    }
    .onChange(of: offset) { oldValue, newValue in
        print(oldValue, newValue)
    }
}
